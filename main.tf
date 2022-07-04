module "vpc" {
    source = "./modules/vpc"
    network_name = var.network_name
    project_id = var.project_id
    auto_create_subnetworks = var.auto_create_subnetworks
    delete_default_routes_on_create = var.delete_default_routes_on_create
    mtu = var.mtu
    routing_mode = var.routing_mode
  
}

module "subnets" {
    source = "./modules/subnets"
    project_id  = var.project_id
    network_name = module.vpc.network_name
    subnets = var.subnets

  
}