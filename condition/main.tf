variable "vm_enable" {
  type    = bool
  default = false
}

resource "google_compute_instance" "default" {
  count = var.vm_enable ? 1 : 0

  name         = "test"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
  }
}
