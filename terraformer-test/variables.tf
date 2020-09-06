data "terraform_remote_state" "local" {
  backend = "local"

  config = {
    path = "terraform.tfstate"
  }
}
