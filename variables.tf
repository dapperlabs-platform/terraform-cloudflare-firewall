variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "firewall_rule" {
  type = object({
    ruleset_id  = string
    description = string
    expression  = string
    action      = string
    enabled     = bool
    bypass      = list(string)
    priority    = number
  })

  default = {
    ruleset_id  = null
    description = "Default description"
    expression  = "default_expression"
    action      = "block"
    enabled     = true
    bypass      = ["default_bypass"]
    priority    = 100
  }
}
