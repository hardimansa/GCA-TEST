output "network" {
  value       = google_compute_network.vpc
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the VPC being created"
}