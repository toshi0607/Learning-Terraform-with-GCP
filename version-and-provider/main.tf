terraform {
  required_version = "~> 1.2"
  required_providers {
    google = ">= 4.32.0"
  }
}

provider "google" {
  # replace 【YOUR PROJECT】 with your project
  # e.g.
  # project = "terraform-toshi0607"
  project = 【YOUR PROJECT】
  zone    = "asia-northeast1-c"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}

output "project" {
  description = "Names of project"
  value       = google_compute_instance.default.project
}

output "zone" {
  description = "Names of zone"
  value       = google_compute_instance.default.zone
}
