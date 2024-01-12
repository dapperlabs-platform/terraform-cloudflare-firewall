variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "ruleset_id" {
  type        = string
  description = "Cloudflare Ruleset ID to be applied to"
  default     = null
}

variable "name" {
  type        = string
  description = "Cloudflare Ruleset Name"
  default     = "default"
}

variable "firewall_rule" {
  type = object({
    description = string
    expression  = string
    action      = string
    enabled     = bool
    bypass      = list(string)
    priority    = number
  })
}
