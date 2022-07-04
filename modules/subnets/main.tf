
locals {
  subnets = {
  for s in var.subnets : "${s.subnet_name}/${s.subnet_region}" => s
}
}


resource "google_compute_subnetwork" "subnet" {
    project = var.project_id
    network = var.network_name
    for_each = local.subnets
    name = each.value.subnet_name
    region = each.value.subnet_region
    ip_cidr_range = each.value.subnet_ip
  

  
}

