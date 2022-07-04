resource "google_compute_network" "vpc" {
    name = var.network_name
    project = var.project_id
    auto_create_subnetworks = var.auto_create_subnetworks
    delete_default_routes_on_create = var.delete_default_routes_on_create
    mtu = var.mtu
    routing_mode = var.routing_mode
  
}


