# https://github.com/terraform-google-modules/terraform-google-network



locals {

    ## PROJECT ##
  project_id = "gcp-terraform-1-353112"

  ### VPC LOCAL ###
  network1_name = "prod"
  network2_name = "dev"
  auto_create_subnetworks = false
  mtu = 1412
  routing_mode = "REGIONAL"
  delete_default_routes_on_create = "true"

  ### SUBNET1 LOCALS ###
  subnet1_name = "prod-1-sub"
  subnet1_region = "us-central1"
  subnet1_ip = "10.10.10.0/24"
  vpc2_subnet1_name = "dev-1-sub"
  vpc2_subnet1_region = "us-central1"
  vpc2_subnet1_ip =  "10.20.20.0/24"

### SUBNET2 LOCALS ###

  subnet2_name = "prod-2-sub"
  subnet2_region = "us-west1"
  subnet2_ip = "192.168.1.0/24"
  vpc2_subnet2_name = "dev-2-sub"
  vpc2_subnet2_region = "us-west1"
  vpc2_subnet2_ip = "192.168.20.0/24"

### FIREWALL LOCALS ###
  firewall-name = "prod-http-deny"
  firewall-direction = "INGRESS"
  firewall-description = "deny-http-to-prod"
  action = "deny"
  ranges = ["0.0.0.0/0"]
  priority = 999
  target_tags = null
  source_tags = null 
  ports = ["80"]
  protocol = "tcp"

### ROUTING LOCALS ###

### Virtual Machine Locals ###
machine_type = "e2-minimal"
startup_script = "echo > /test.txt"

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
    description = local.firewall-description
    direction = local.firewall-direction
    action = local.action
    ranges = local.ranges
    source_tags = local.source_tags
    priority = local.priority
    name = local.firewall-name
    target_tags = local.target_tags
    source_tags = local.source_tags

    allow = []

    deny = [{
        protocol = local.protocol
        ports = local.ports
    }]
   }
   ]

    }

    module "vpc_2" {
    source = "../"
    project_id = local.project_id
    network_name = local.network2_name
    auto_create_subnetworks = local.auto_create_subnetworks
    mtu = local.mtu
    routing_mode = local.routing_mode
    delete_default_routes_on_create = local.delete_default_routes_on_create

    subnets = [ {
        subnet_name = local.vpc2_subnet1_name
        subnet_region = local.vpc2_subnet1_region
        subnet_ip = local.vpc2_subnet1_ip
        },

        {
        subnet_name = local.vpc2_subnet2_name
        subnet_region = local.vpc2_subnet2_region
        subnet_ip = local.vpc2_subnet2_ip
        }
       ]

      
    }
   

