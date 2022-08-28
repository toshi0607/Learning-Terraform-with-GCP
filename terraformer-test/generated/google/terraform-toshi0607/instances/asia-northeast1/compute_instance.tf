resource "google_compute_instance" "tfer--test-terraformer" {
  boot_disk {
    auto_delete = "true"
    device_name = "persistent-disk-0"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/terraform-toshi0607/zones/asia-northeast1-c/disks/test-terraformer"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
  machine_type        = "f1-micro"
  name                = "test-terraformer"

  network_interface {
    access_config {
      nat_ip       = "34.85.42.30"
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/terraform-toshi0607/global/networks/default"
    network_ip         = "10.146.15.207"
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/terraform-toshi0607/regions/asia-northeast1/subnetworks/default"
    subnetwork_project = "terraform-toshi0607"
  }

  project = "terraform-toshi0607"

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "474715178574-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  zone = "asia-northeast1-c"
}
