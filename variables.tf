variable "network_name" {
  
}
variable "project_id" {
  
}
variable "auto_create_subnetworks" {
  
}
variable "mtu" {
  
}
variable "routing_mode" {
  
}
variable "delete_default_routes_on_create" {
  
}
variable "subnets" {
    type = list(map(string))
  
}
variable "rules" {
    default = []
    type = list(object({
        name = string
        description = string
        direction = string
        priority = number
        ranges = list(string)
        source_tags = list(string)
        target_tags = list(string)

        allow = list(object({
            protocol = string
            ports = list(string)
        }))
        deny = list(object({
            protocol = string
            ports = list(string)
        }))
    }))
   }

