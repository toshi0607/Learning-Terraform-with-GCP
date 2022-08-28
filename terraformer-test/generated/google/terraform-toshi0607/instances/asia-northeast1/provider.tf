provider "google" {
  project = "terraform-toshi0607"
}

terraform {
	required_providers {
		google = {
	    version = "~> 4.32.0"
		}
  }
}
