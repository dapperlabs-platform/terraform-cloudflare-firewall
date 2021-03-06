variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "firewall_rule" {
  type = object({
    description = string
    expression  = string
    action      = string
    paused      = bool
    bypass      = list(string)
    priority    = number
  })

}
