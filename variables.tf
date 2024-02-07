variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "firewall_rules" {
  type = map(object({
    action      = string,
    expression  = string,
    description = string,
    enabled     = bool,
    phases      = optional(list(string))
  }))
}
