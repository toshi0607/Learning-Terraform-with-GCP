variable "gcp_project" {
  type        = string
  description = "GCP project name"
}

# https://cloud.google.com/compute/docs/regions-zones
variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
}
