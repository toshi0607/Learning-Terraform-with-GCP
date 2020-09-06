terraform {
  required_version = "~> 0.13"
  required_providers {
    google = ">= 3.33.0"
  }
}

provider "google" {
  # 【YOUR PROJECT】をあなたのGCPプロジェクトに置き換えてください。
  project = 【YOUR PROJECT】
  zone    = "asia-northeast1-a"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
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
