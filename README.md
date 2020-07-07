# Consul NIA Module

Consul NIA stands for Consul Network Infrastructure Automation. This module is
designed for Consul NIA to run in full automation with files and
Terraform variables that are generated from templates.

The Consul NIA Terraform module generalizes service definitions to manage Consul
services across a number of network infrastructure. This abstracts provider
specific management of network devices, like load balancers and firewalls, for
a service.

The project contains submodules that encapsulate Consul NIA automation
workflows. All of the submodules are compatible with the declared input
variables found in the root `variables.tf` file.

## Prerequisite
Terraform CLI version `0.13` or later is required to support syntax used
throughout the module.

## Quick Start
This section outlines steps to run the Consul NIA workflow to update Palo Alto
Networks Next-Generation Firewall with addresses for Consul-managed services.

The root module contains a `main.tf.example` file that exemplifies how to setup
a root module to call a submodule along with an example variable definitions
file `nia.tfvars.example`. Make a copy of these files and update the values in
`nia.tfvars` with your information. 

```
$ cp main.tf.example main.tf
$ cp nia.tfvars.example nia.tfvars
```

Execute Terraform commands to make changes to the firewall.

```
$ terraform init
Initializing modules...
- panos in modules/panos-ngfw

Initializing the backend...

Initializing provider plugins...
- Finding terraform-providers/panos versions matching ">= 1.6.2"...
- Installing terraform-providers/panos v1.6.2...
- Installed terraform-providers/panos v1.6.2 (signed by HashiCorp)

Terraform has been successfully initialized!
...

$ terraform plan --var-file=nia.tfvars
$ terraform apply --var-file-nia.tfvars
```
