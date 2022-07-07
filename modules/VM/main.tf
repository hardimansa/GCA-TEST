resource "google_compute_instance" "vm" {
  project = "gcp-terraform-1-353112"
  name = "prod"
  zone = "us-west1-c"

  boot_disk {
    initialize_params {
        image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "prod"
    subnetwork = "projects/gcp-terraform-1-353112/regions/us-west1/subnetworks/prod-2-sub"
   
  }
  machine_type = "f1-micro"
  }



