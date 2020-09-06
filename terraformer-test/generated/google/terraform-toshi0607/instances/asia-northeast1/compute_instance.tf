resource "google_compute_instance" "tfer--test-002D-terraformer" {
  boot_disk {
    auto_delete = "true"
    device_name = "test-terraformer"

    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-9-stretch-v20200805"
      size  = "10"
      type  = "pd-standard"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/terraform-toshi0607/zones/asia-northeast1-a/disks/test-terraformer"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
  machine_type        = "e2-medium"
  name                = "test-terraformer"

  network_interface {
    access_config {
      nat_ip       = "34.84.186.207"
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/terraform-toshi0607/global/networks/default"
    network_ip         = "10.146.0.41"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/terraform-toshi0607/regions/asia-northeast1/subnetworks/default"
    subnetwork_project = "terraform-toshi0607"
  }

  project = "terraform-toshi0607"

  scheduling {
    automatic_restart   = "true"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "474715178574-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/trace.append", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/service.management.readonly"]
  }

  zone = "asia-northeast1-a"
}
