resource "bigip_as3" "consul_services" {
  # https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/composing-a-declaration.html
  as3_json = templatefile(
    "as3.tmpl",
    {
      tenant_name = jsonencode("consul-nma")
      # Template each service declaration to insert into the as3 tenant declaration
      service_declarations = jsonencode([for s in var.services : templatefile(
        "as3_service_declaration.tmpl",
        {
          service           = jsonencode(each.name)
          addresses         = jsonencode(each.addresses)
          virtual_addresses = jsonencode(var.virtual_address[each.name])
        }
      )])
    }
  )
}

variable "virtual_addresses" {
  description = "Virtual Address for TODO"
  type        = map(list(string))
  default     = {}
}

variable "services" {
  description = "Consul services monitored by NMA"
  type = list(object({
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
  }))
  default = []
}
