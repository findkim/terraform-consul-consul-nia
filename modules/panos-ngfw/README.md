# Consul NIA: PAN-OS NGFW Module

Terraform module manages a PAN-OS Next Generation Firewall security policy rule
for Consul services. It creates a security policy on a dynamic address group
that is filtered by address objects with the `consul-nia` tag.

The module creates the following resources:
* Application object representing Consul NIA
* Security policy rule for Consul services mantained by Consul NIA
* Administrative tag used for dynamic address group filtering
* Dynamic address group for the Consul services
* Address objects for each address of the Consul services

**Note**: Commits are handled out-of-band from Terraform and are made by Consul NIA.

## Usage

```hcl
module "panos" {
	source = "findkim/consul-nia/consul//modules/panos-ngfw"

	services = {
		web: {
			name         = "web"
			addresses    = ["192.0.0.1", "192.0.0.2"]
			sources      = []
			destinations = []
		}
	}
}
```
