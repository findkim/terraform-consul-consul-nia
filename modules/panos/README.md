# Consul NIA: PANOS Module

Terraform module manages PANOS firewall security policy rules for Consul
services.

The module creates an application object representing each Consul service,
security policy rules, and an administrative tag. A firewall rule is created
for each service to known node IPs required for inbound and outbound requests,
which corresponds with [Consul upstreams](https://www.consul.io/docs/connect/registration/service-registration.html#upstreams) specified in the Consul Catalog.
For inbound requests, the service is the destination and all Consul services
that have it configured as an upstream is the source. For outbound requests,
the service is the source and its upstreams are the destinations.

Each resource and security policy rule managed by this module is tagged with
`consul-nia` to help identify automated resources created by Consul NIA.

**Note**: Commits are handled out-of-band from Terraform and are made by Consul NIA.

## Usage

```hcl
module "panos" {
	source = "findkim/terraform-consul-nia//modules/panos"

	services = {
		web: {
			name         = "web"
			addresses    = ["192.0.0.1:8000", "192.0.0.2:8000"]
			sources      = ["192.0.0.1:8080"]
	    	destinations = []
	    }
	}
}
```
