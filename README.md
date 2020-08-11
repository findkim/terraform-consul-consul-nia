# PAN-OS NGFW Module

Terraform module manages a PAN-OS Next Generation Firewall security policy rule
for Consul services. It creates a security policy on a dynamic address group
that is filtered by address objects with the `consul-nia` tag.

The module creates the following resources:
* Application object representing Consul NIA
* Security policy rule for Consul services mantained by Consul NIA
* Administrative tag used for dynamic address group filtering
* Dynamic address group for the Consul services
* Address objects for each address of the Consul services

~> **Note** Commits are handled out-of-band from Terraform and can be done manually (through the firewall web UI or executing a [commit script](https://www.terraform.io/docs/providers/panos/index.html#commits)) or can be managed by Consul NIA when run in automation.

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
  web : {
    name        = "web"
    description = "frontend web application"
    
    # Dynamic values discovered from Consul Catalog
    addresses = [
      {
        address = "1.1.1.1"
        port = 80
      },
      {
        address = "1.1.1.2"
        port = 80
      }
    ]
  }
  api : {
    name        = "api"
    description = "backend API for web application"

    # Dynamic values discovered from Consul Catalog
    addresses = [
      {
        address = "2.2.2.1"
        port = 8080
      },
      {
        address = "2.2.2.2"
        port = 8080
      }
    ]
  }
}
```

# Consul NIA Compatible

!> **Caution** Consul NIA is in active development. This module is used for testing and demonstrating varying features supported by Consul NIA. **It has not been extensively tested and is not intended to use for production environments.**

This is an example module that is designed for Consul NIA to run in full automation. The module consumes from `services` variable which represents service network information from Consul Catalog. Consul NIA monitors a set of services for network changes and dynamically updates the `services` value.

Consul NIA generates Terraform configuration files that make up the root module which calls compatible child modules, like this one, and passes required and optional arguments to the child module. The above example `main.tf` and `terraform.tfvars` would be files created by Consul NIA.
