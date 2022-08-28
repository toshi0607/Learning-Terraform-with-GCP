moved {
  from = google_compute_instance.before-move
  to   = google_compute_instance.after-move
}

resource "google_compute_instance" "after-move" {
# resource "google_compute_instance" "before-move" {
  name         = "moved"
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
}
