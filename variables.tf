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
  type        = list(string)
  description = "A list to contain country codes of traffic that will be blocked"
  default = [
    "DZ", # Algeria
    "AF", # Afghanistan
    "BD", # Bangladesh
    "BY", # Belarus
    "CF", # Central African Republic
    "CD", # The Democratic Republic of Congo
    "CU", # Cuba
    "ET", # Ethiopia
    "ER", # Eritrea
    "PS", # Palestinian Territory (Gaza Strip / West Bank)
    "IR", # Iran
    "IQ", # Iraq
    "XK", # Kosovo
    "LB", # Lebanon
    "LY", # Libya
    "ML", # Mali
    "MA", # Morocco
    "MM", # Myanmar (Burma)
    "NI", # Nicaragua
    "NE", # Niger
    "KP", # North Korea
    "PK", # Pakistan
    "QA", # Qatar
    "RU", # Russia
    "SI", # Slovenia
    "SO", # Somalia
    "SS", # South Sudan
    "SD", # Sudan
    "SY", # Syrian Arab Republic
    "UA", # Ukraine
    "YE", # Yemen
    "ZW", # Zimbabwe
  ]
}

