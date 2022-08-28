resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}

output "cpu_platform" {
  description = "CPU platform of the instance"
  value       = google_compute_instance.default.cpu_platform
}
