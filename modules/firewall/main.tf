
resource "google_compute_firewall" "firewall" {
  project = var.project_id
  network = var.network_name
  for_each = { for r in var.rules : r.name => r }
  name = each.value.name
  direction = each.value.direction
  description = each.value.description
  source_ranges = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges = each.value.direction == "EGRESS" ? each.value.ranges : null 
  source_tags = each.value.source_tags
  target_tags = each.value.target_tags
  

  dynamic "allow" { 
    for_each = lookup(each.value, "allow", [] )
        content {
            protocol = allow.value.protocol
            ports = lookup(each.value, "ports", null)
        }
  }

  dynamic "deny" { 
    for_each = lookup(each.value, "deny", [])
        content { 
            protocol = deny.value.protocol
            ports = lookup(deny.value, "ports", null)            
        }
  }
}
