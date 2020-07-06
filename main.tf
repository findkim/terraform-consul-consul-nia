# main.tf is downloaded from somewhere

terraform {
  required_version = ">= 0.13"

  # backend "consul" {
  #   # Variables are not allowed for address and access_token
  #   # Consul NIA will need to write these as ENV
  #   # address      = var.consul.address
  #   # access_token = var.consul.access_token
  #   scheme       = "https"
  #   path         = "consul-nia/terraform"
  # }
}

module "panos" {
  source = "./modules/panos-ngfw"
  count  = var.panos != null ? 1 : 0

  services = { for name in var.service_mapping["panos"] : name => var.services[name] if length(var.services[name].addresses) > 0 }
}

provider "panos" {
  hostname = var.panos.hostname
  username = var.panos.username
  password = var.panos.password
  api_key  = var.panos.api_key
  protocol = var.panos.protocol != null ? var.panos.protocol : "https"
  port     = var.panos.port != null ? var.panos.port : 0
  timeout  = var.panos.timeout != null ? var.panos.timeout : 10
}
