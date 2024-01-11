variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "firewall_rule" {
  type = object({
    rulesets_id = string
    description = string
    expression  = string
    action      = string
    enabled     = bool
    bypass      = list(string)
    priority    = number
  })

}
