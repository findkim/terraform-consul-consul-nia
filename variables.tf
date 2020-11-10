variable "services" {
  description = "Consul services monitored by Consul Terraform Sync"
  type = map(
    object({
      id        = string
      name      = string
      address   = string
      port      = number
      status    = string
      meta      = map(string)
      tags      = list(string)
      namespace = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)
    })
  )
}

variable "tag_name" {
  description = "The name of the tag to create and use for dynamic address group filtering of Consul service IPs"
  type        = string
  default     = "consul-terraform-sync"
}

variable "consul_service_tags" {
  description = "Adminstrative tags to add to Consul service address objects. These are existing tags on PAN-OS."
  type        = list(string)
  default     = []
}

variable "address_group_tags" {
  description = "Adminstrative tags to add to the address group for Consul service addresses. These are existing tags on PAN-OS."
  type        = list(string)
  default     = []
}

variable "security_policy_rule_name" {
  description = "Name of the security policy rule for managing Consul service addresses"
  type        = string
  default     = "consul-terraform-sync-security-policy"
}

variable "security_policy_rule_description" {
  description = "A text field, up to 1024 chracters, used to describe the rule"
  type        = string
  default     = "Security policy generated by Consul Terraform Sync to manage addresses of Consul services"
}

variable "position_keyword" {
  description = "A positioning keyword for this group. This can be before, directly before, after, directly after, top, bottom, or left empty (the default) to have no particular placement. This param works in combination with the position_reference param."
  type        = string
  default     = "before"
}

variable "position_reference" {
  description = "Required if position_keyword is one of the `above` or `below` variants, this is the name of a non-group rule to use as a reference to place this group."
  type        = string
  default     = "Log default deny"
}

## Optional security profiles to configure the security policy
variable "profile_group" {
  type        = string
  description = "(Optional) Profile Setting: Group - The group profile name."
  default     = null
}

variable "profile_virus" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The antivirus setting."
  default     = null
}

variable "profile_spyware" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The anti-spyware setting."
  default     = null
}

variable "profile_vulnerability" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The Vulnerability Protection setting."
  default     = null
}

variable "profile_url_filtering" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The URL filtering setting."
  default     = null
}

variable "profile_file_blocking" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The file blocking setting."
  default     = null
}

variable "profile_wildfire_analysis" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The WildFire Analysis setting."
  default     = null
}

variable "profile_data_filtering" {
  type        = string
  description = "(Optional) Profile Setting: Profiles - The Data Filtering setting."
  default     = null
}
