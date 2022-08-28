variable "project" {
  description = "A name of a GCP project"
  type        = string
  default     = null
}


variable "zone" {
  description = "A zone used in a compute instance"
  type        = string
  default     = "asia-northeast1-c"

  validation {
    condition     = contains(["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"], var.zone)
    error_message = "The zone must be in asia-northeast1 region."
  }
}

variable "service_name" {
  description = "A name of a service"
  type        = string
}

variable "environment" {
  description = "An environment of a service"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "The environment must be development, staging or production."
  }
}

variable "machine_type" {
  description = "A machine type of a compute instance"
  type        = string
  default     = "f1-micro"
}
