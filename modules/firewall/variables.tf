variable "project_id" {
  
}
variable "network_name" {
  
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