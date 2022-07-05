# https://github.com/terraform-google-modules/terraform-google-network



locals {

    ## PROJECT ##
  project_id = "gcp-terraform-1-353112"

  ### VPC LOCAL ###
  network1_name = "prod"
  auto_create_subnetworks = false
  mtu = 1412
  routing_mode = "REGIONAL"
  delete_default_routes_on_create = "true"

  ### SUBNET1 LOCALS ###
  subnet1_name = "prod-1-sub"
  subnet1_region = "us-central1"
  subnet1_ip = "10.10.0.0/16"

### SUBNET2 LOCALS ###

  subnet2_name = "prod-2-sub"
  subnet2_region = "us-west1"
  subnet2_ip = "192.168.1.0/24"

### FIREWALL LOCALS ###



### ROUTING LOCALS ###
}



module "vpc_1" {
    source = "../"
    project_id = local.project_id
    network_name = local.network1_name
    auto_create_subnetworks = local.auto_create_subnetworks
    mtu = local.mtu
    routing_mode = local.routing_mode
    delete_default_routes_on_create = local.delete_default_routes_on_create

    #### START OF SUBNET ####
    subnets = [ {
        subnet_name = local.subnet1_name
        subnet_region = local.subnet1_region
        subnet_ip = local.subnet1_ip
        },

        {
        subnet_name = local.subnet2_name
        subnet_region = local.subnet2_region
        subnet_ip = local.subnet2_ip
        }
       ]
   rules = [ {

            description = "Deny HTTP"
            direction = "INGRESS"
            action = "deny"
            ranges = ["0.0.0.0/0"]
            source_tags = "web"
            priority = 1000
            name = "deny-http"
            target_tags = null
            source_tags = null
        
        allow = []


        deny = [{
            protocol = "tcp"
            ports = ["80"]
        }]
            
        } ]
    }
   

