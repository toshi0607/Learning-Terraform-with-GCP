locals {
  common_labels = {
    service     = var.service_name
    environment = var.environment
  }
}

resource "google_compute_instance" "default" {
  project = var.project
  zone    = var.zone

  name = "${var.service_name}-vm"

  machine_type = var.machine_type

  labels = local.common_labels

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}
