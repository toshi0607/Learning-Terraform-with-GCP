resource "google_compute_instance" "default" {
  // Change when trying create_before_destroy sample 
  // name         = "test2" 
  name         = "test"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-c"

  boot_disk {
    initialize_params {
      # gcloud compute images list | grep debian, if the image can't be found
      image = "debian-cloud/debian-11"
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
