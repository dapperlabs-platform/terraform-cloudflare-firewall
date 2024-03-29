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
