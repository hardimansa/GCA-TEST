locals {
  project_id = "gcp-terraform-1-353112"
  network1_name = "prod"
  auto_create_subnetworks = false
  mtu = 1412
  routing_mode = "REGIONAL"
  delete_default_routes_on_create = "true"
}



module "vpc_1" {
    source = "../"
    project_id = local.project_id
    network_name = local.network1_name
    auto_create_subnetworks = local.auto_create_subnetworks
    mtu = local.mtu
    routing_mode = local.routing_mode
    delete_default_routes_on_create = local.delete_default_routes_on_create

  
}