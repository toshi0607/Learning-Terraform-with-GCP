resource "google_compute_instance" "tf_fmt_example" {
  name         = "tf-fmt-test"
  machine_type = "f1-micro"
  zone = "asia-northeast1-c"

  boot_disk {
    initialize_params {
      image  = "debian-cloud/debian-11"
    }
  }

  network_interface {
  network = "default"
  }
}
