variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "firewall_rules" {
  type = map(object({
    description = string,
    expression  = string,
    action      = string,
    enabled     = bool,
    logging     = optional(bool, true)
    ruleset     = optional(string)
    phases      = optional(list(string))
  }))
}

variable "country_block_list" {
  type        = map(string)
  description = "A list to contain country codes of traffic that will be blocked"
  default     = {}
}

