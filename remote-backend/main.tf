terraform {
  backend "gcs" {
    # replace 【YOUR BUCKET】 with your project
    # e.g.
    # bucket = "tf-state-toshi0607-20200827-dev"
    bucket = 【YOUR BUCKET】
    prefix = "terraform/state"
  }

  required_providers {
    google = ">= 4.32.0"
  }
}

provider "google" {
  # replace 【YOUR PROJECT】 with your project
  # e.g.
  # project = "terraform-toshi0607"
  project = 【YOUR PROJECT】
  region  = "asia-northeast1"
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
