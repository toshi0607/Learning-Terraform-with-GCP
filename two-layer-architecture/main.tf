terraform {
  required_version = ">= 1.2"
}

# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "default-"
  machine_type = "f1-micro"
  region       = var.gcp_region

  metadata_startup_script = file("./gceme.sh.tpl")

  tags = ["allow-ssh", "allow-service"]

  disk {
    source_image = "debian-cloud/debian-11"
  }

  service_account {
    # https://cloud.google.com/compute/docs/access/service-accounts#authorization
    scopes = ["cloud-platform"]
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
  }

  # Instance Templates cannot be updated after creation with the Google Cloud Platform API
  lifecycle {
    create_before_destroy = true
  }
}

# Router and Cloud NAT are required for installing packages from repos (apache, php etc)
resource "google_compute_router" "default" {
  name    = "default"
  network = "default"
  region  = var.gcp_region
}

resource "google_compute_router_nat" "default" {
  name   = "default"
  router = google_compute_router.default.name
  region = google_compute_router.default.region
  # https://www.terraform.io/docs/providers/google/r/compute_router_nat.html#source_subnetwork_ip_ranges_to_nat
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  # https://www.terraform.io/docs/providers/google/r/compute_router_nat.html#nat_ip_allocate_option
  nat_ip_allocate_option = "AUTO_ONLY"
}

resource "google_compute_region_instance_group_manager" "default" {
  name   = "default"
  region = var.gcp_region
  version {
    instance_template = google_compute_instance_template.default.self_link
  }

  base_instance_name = "mig"
  target_size        = null

  auto_healing_policies {
    health_check      = google_compute_health_check.mig_health_check.self_link
    initial_delay_sec = 30
  }

  // Initial instance verification can take 10-15m when a health check is present.
  timeouts {
    create = "15m"
  }
}

resource "google_compute_region_autoscaler" "default" {
  name = "default"

  target = google_compute_region_instance_group_manager.default.self_link
  autoscaling_policy {
    max_replicas = 3
    min_replicas = 1
  }
}

resource "google_compute_health_check" "mig_health_check" {
  name = "default"

  http_health_check {
    port = 80
  }
}

resource "google_compute_firewall" "mig_health_check" {
  name = "health-check"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = [80]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-service"]
}

resource "google_compute_firewall" "default_ssh" {
  name    = "default-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = [22]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_backend_service" "backend1" {
  name = "backend1"
  backend {
    group = google_compute_region_instance_group_manager.default.instance_group
  }
  health_checks = [google_compute_health_check.mig_health_check.self_link]
}

resource "google_compute_url_map" "default" {
  name            = "default"
  default_service = google_compute_backend_service.backend1.self_link
}

resource "google_compute_target_https_proxy" "default" {
  name             = "default"
  url_map          = google_compute_url_map.default.self_link
  ssl_certificates = [google_compute_ssl_certificate.example.self_link]
}

resource "google_compute_ssl_certificate" "example" {
  name        = "example"
  private_key = tls_private_key.example.private_key_pem
  certificate = tls_self_signed_cert.example.cert_pem
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert
resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  # Certificate expires after 12 hours.
  validity_period_hours = 12

  # Generate a new certificate if Terraform is run within three
  # hours of the certificate's expiration time.
  early_renewal_hours = 3

  # Reasonable set of uses for a server SSL certificate.
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = ["example.com", "example.net"]

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }
}

resource "google_compute_global_forwarding_rule" "default" {
  name   = "default"
  target = google_compute_target_https_proxy.default.self_link
  # https://www.terraform.io/docs/providers/google/r/compute_global_forwarding_rule.html#port_range
  port_range = "443"
}
