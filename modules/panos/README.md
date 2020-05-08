# Consul NMA: PANOS Module

Terraform module manages PANOS firewall security policy rules for Consul
services.

The module creates an application object for each Consul service and
corresponding security policy rules. A rule is specified for each service
allowing network communication from source addresses to the service, and
communication from the service to destination addresses.

## Usage

```hcl
module "panos" {
	source = "findkim/terraform-consul-nma//modules/panos"

	services = [{
		name = "web"
		addresses = ["192.0.0.1:8000", "192.0.0.2:8000"]
		sources      = ["192.0.0.1:8080"]
    	destinations = null
	}]
}
```
