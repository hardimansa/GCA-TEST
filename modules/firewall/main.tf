resource "google_compute_firewall" "firewall" {
  project = var.project_id
  network = var.network_name
  for_each = { for r in var.rules : r.name => r }
  name = each.value.name
  direction = each.value.direction
  description = each.value.description
  

  dynamic "allow" { 
    for_each = lookup(each.value, "allow", [] )
        content {
            protocol = allow.value.protocol
            ports = lookup(each.value, "ports", null)
        }
  }
}
