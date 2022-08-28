provider "google" {
  version = ">= 4.32.0"
}

resource "google_project_service" "gcp_api_service" {
  service = "iam.googleapis.com"

  disable_dependent_services = true
}
