# Consul NIA: Big-IP AS3 Module

Terraform module generates an AS3 declaration for services managed by Consul
and monitored by Consul NIA.

One AS3 declaration is created for the `consul-nia` tenant, and each Consul
service falls under an application class.

## Usage

```hcl
module "bigip" {
	source = "findkim/terraform-consul-nia//modules/bigip"

	address = "localhost:8080"
	services = {
		web: {
			name = "web"
			addresses = ["192.0.0.1:8000", "192.0.0.2:8000"]
			virtual_addresses = ["virtual-address.io"]
		}
	}
}
```
