terraform {
  backend "gcs" {
    # replace 【YOUR BUCKET】 with your project
    # e.g.
    # bucket = "tf-state-toshi0607-20200827-dev"
    bucket = 【YOUR BUCKET】
    prefix  = "terraform/test_instance/state"
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "test_instance" {
  source = "../modules"

  project      = var.project
  zone         = var.zone
  service_name = "test-development"
  environment  = "development"
}
