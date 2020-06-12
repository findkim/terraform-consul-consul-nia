terraform {
  required_providers {
    bigip = {
      source = "terraform-providers/bigip"
      version = ">= 1.1.2"
    }
  }
}

resource "bigip_as3" "consul_services" {
  # https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/composing-a-declaration.html
  as3_json = templatefile(
    "as3.tmpl",
    {
      tenant_name = jsonencode("consul-nia")
      # Template each service declaration to insert into the as3 tenant declaration
      # TODO still need to fix up templating for service declaration to change from
      # `{ "service1": {}, "service2": {} }` to `"service1": {}, "service2": {}`
      service_declarations = jsonencode({ for s in var.services : s.name => templatefile(
        "as3_service_declaration.tmpl",
        {
          service           = jsonencode(each.name)
          addresses         = jsonencode(each.addresses)
          virtual_addresses = jsonencode(each.virtual_addresses)
        }
      ) })
    }
  )
}

variable "services" {
  description = "Consul services monitored by Consul NIA"
  type = list(object({
    # Name of the service
    name = string
    # Description of the service
    description = string
    # List of addresses for instances of the service
    addresses = list(string)
    # List of virtual addresses load balanced services
    virtual_addresses = list(string)
  }))
}
