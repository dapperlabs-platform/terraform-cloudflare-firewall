variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "firewall_rules" {
  type = list(object({
    action      = string,
    expression  = string,
    description = string,
    enabled     = bool,
    action_parameters = list(object({
      phases = list(string),
    })),
  }))
}
