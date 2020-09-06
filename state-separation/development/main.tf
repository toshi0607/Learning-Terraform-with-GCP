terraform {
  backend "gcs" {
    # bucket  = "tf-state-toshi0607-20200827-dev"
    # 【YOUR BUCKET】を作成したバケット名に置き換えてください。
    bucket = 【YOUR BUCKET】
    prefix  = "terraform/test_instance/state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/google"
      version = ">= 3.33.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "test_instance_dev" {
  source = "./modules"

  project      = var.project
  zone         = var.zone
  service_name = "test-development"
  environment  = "development"
}
