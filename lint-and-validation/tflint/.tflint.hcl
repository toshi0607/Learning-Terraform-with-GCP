plugin "google" {
    enabled = true
    version = "0.19.0"
    source  = "github.com/terraform-linters/tflint-ruleset-google"
}

rule "google_compute_address_invalid_address_type" {
  enabled = true  
}
