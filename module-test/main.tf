provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "test_instance" {
  source = "./modules"

  project      = var.project
  zone         = var.zone
  service_name = "test-service"
  environment  = "development"
}
