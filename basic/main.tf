resource "google_compute_instance" "default" {
  // Change when trying create_before_destroy sample 
  // name         = "test2" 
  name         = "test"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
  }

  # create_before_destroy sample
  # lifecycle {
  #   create_before_destroy = true
  # }
}
