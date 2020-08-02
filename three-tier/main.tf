terraform {
  required_version = ">= 0.12"
}

# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
  credentials = file(var.gcp_auth_file_path)
}

resource "google_compute_network" "default" {
  name                    = "multi-mig"
  auto_create_subnetworks = "false"
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "default-"
  machine_type = "f1-micro"
  region       = var.gcp_region

  metadata_startup_script = file("./gceme.sh.tpl")

  tags = ["allow-ssh", "allow-service"]
  labels = {
    "key" = "value"
  }

  disk {
    source_image = "debian-cloud/debian-9"
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/devstorage.full_control",
    ]
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

module "cloud-nat-group1" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "1.0.0"
  router     = google_compute_router.default.name
  project_id = var.gcp_project
  region     = var.gcp_region
  name       = "default"
}

resource "google_compute_region_instance_group_manager" "default" {
  name   = "default"
  region = var.gcp_region
  version {
    instance_template = google_compute_instance_template.default.self_link
  }

  base_instance_name = "mig"
  target_size        = null

  update_policy {
    type           = "OPPORTUNISTIC"
    minimal_action = "REPLACE"
  }

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

  check_interval_sec  = 30
  timeout_sec         = 10
  healthy_threshold   = 1
  unhealthy_threshold = 10

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
