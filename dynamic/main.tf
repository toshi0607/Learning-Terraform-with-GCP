variable node_affinities {
  type    = list(object({ key = string, value= string}))
  default = [{key = "env", value = "dev"}, {key = "layer", value = "front"}]
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  scheduling {
    dynamic "node_affinities" {
      for_each = var.node_affinities
      content {
        key = node_affinities.value["key"]
        operator = "IN"
        values   = [node_affinities.value["value"]]
      }
    }
  }
}
