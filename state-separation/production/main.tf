terraform {
  backend "gcs" {
    # bucket  = "tf-state-toshi0607-20200827-prod"
    # 【YOUR BUCKET】を作成したバケット名に置き換えてください。
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
  service_name = "test-production"
  environment  = "production"
}
