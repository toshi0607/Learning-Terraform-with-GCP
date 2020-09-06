terraform {
  backend "gcs" {
    # bucket = "tf-state-toshi0607-20200827-dev"
    # 【YOUR BUCKET】を作成したバケット名に置き換えてください。
    bucket = 【YOUR BUCKET】
    prefix = "terraform/state"
  }

  required_providers {
    google = ">= 3.33.0"
  }
}

provider "google" {
  # project = "terraform-toshi0607"
  # 【YOUR PROJECT】をあなたのGCPプロジェクトに置き換えてください。
  project = 【YOUR PROJECT】
  region  = "asia-northeast1"
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
