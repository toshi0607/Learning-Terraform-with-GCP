resource "google_compute_instance" "tf_validate_example" {
  name         = "tf-validate-test"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params = {
      image  = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = var.hoge
  }
}
