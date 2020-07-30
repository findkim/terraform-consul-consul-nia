variable "services" {
  description = "Consul services monitored by Consul NIA"
  type = map(object({
    # Name of the service
    name = string
    # Description of the service
    description = string
    # List of addresses for instances of the service by IP and port
    addresses = list(object({
      address = string
      port    = number
    }))
  }))
}

#
# Provider variables mapping to configuraiton for provider blocks
#

variable "panos" {
  description = "Configuration object for PANOS provider"
  type = object({
    hostname = string
    username = string
    password = string
    api_key  = string
    protocol = string
    port     = number
    timeout  = number
  })
  default = null
}
