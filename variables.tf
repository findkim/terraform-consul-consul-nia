# variable "consul_address" {
#   description = "Configuration for Consul as a state storage backend"
#   type        = string
# }

variable "services" {
  description = "Consul services monitored by Consul NIA"
  type = map(object({
    # Name of the service
    name = string
    # Description of the service
    description = string
    # List of addresses for instances of the service
    addresses = list(string)
    # List of source addresses that initiates network communcation with
    # the service
    sources = list(string)
    # List of destination addresses that the service initiates network
    # communication with
    destinations = list(string)
    # List of virtual addresses load balanced services
    virtual_addresses = list(string)
  }))
}

variable "service_mapping" {
  description = "A map of provider names to consul service IDs to be managed by Consul NIA"
  type        = map(list(string))
  default = {
    panos = []
  }
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
