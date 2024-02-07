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
    action_parameters = object({
      phases = optional(list(string)),
    }),
  }))
}
