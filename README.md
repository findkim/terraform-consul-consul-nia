# PAN-OS NGFW Module

Terraform module manages a PAN-OS Next Generation Firewall security policy rule
for Consul services. It creates a security policy on a dynamic address group
that is filtered by address objects with the `consul-terraform-sync` tag.

The module creates the following resources:
* Application object representing Consul Terraform Sync
* Security policy rule for Consul services mantained by Consul Terraform Sync
* Administrative tag used for dynamic address group filtering
* Dynamic address group for the Consul services
* Address objects for each address of the Consul services

~> **Note** Commits are handled out-of-band from Terraform and can be done manually (through the firewall web UI or executing a [commit script](https://www.terraform.io/docs/providers/panos/index.html#commits)) or can be managed by Consul Terraform Sync when run in automation.

## Usage

Example `main.tf` file in a root module
```hcl
provider "panos" {
  username = var.username
  api_key  = var.api_key
}

module "ngfw" {
  source = "findkim/ngfw/panos"

  # Required argument
  services = var.services
  
  # Optional arguments
  tag_name = var.tag_name
}
```

Example `terraform.tfvars` file
```hcl
services = {
  "000000000000:nodea:5000" : {
    address = "172.17.0.3"
    id      = "000000000000:nodea:5000"
    name    = "foobar"
    port    = 5000
    status  = "passing"
    meta = {
      foobar_meta_value = "baz"
    }
    tags            = ["tacos"]
    namespace       = "default"
    node            = "foobar"
    node_id         = "00000000-0000-0000-0000-000000000000"
    node_address    = "192.168.10.10"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.10"
      wan = "10.0.10.10"
    }
    node_meta = {
      somekey = "somevalue"
    }
  }
}

```

# Consul Terraform Sync Compatible

!> **Caution** Consul Terraform Sync is in active development. This module is used for testing and demonstrating varying features supported by Consul Terraform Sync. **It has not been extensively tested and is not intended to use for production environments.**

This is an example module that is designed for Consul Terraform Sync to run in full automation. The module consumes from `services` variable which represents service network information from Consul Catalog. Consul Terraform Sync monitors a set of services for network changes and dynamically updates the `services` value.

Consul Terraform Sync generates Terraform configuration files that make up the root module which calls compatible child modules, like this one, and passes required and optional arguments to the child module. The above example `main.tf` and `terraform.tfvars` would be files created by Consul Terraform Sync.
