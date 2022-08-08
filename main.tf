# Cloudflare Firewall Rules
# Firewall rules for all Zones Defined
data "cloudflare_zones" "zones" {
  filter {
    lookup_type = "exact"
    name        = "sre.dapperlabs.com"
    paused      = false
  }
}

# Cloudflare Filters needed to make a CF FW rule
resource "cloudflare_filter" "filter" {
  for_each = toset(var.domains)

  zone_id     = data.cloudflare_zones.zones.zones[0].id
  paused      = var.firewall_rule.paused
  expression  = var.firewall_rule.expression
  description = var.firewall_rule.description

}

# Firewall Rule
resource "cloudflare_firewall_rule" "rule" {
  for_each = toset(var.domains)

  zone_id     = data.cloudflare_zones.zones.zones[0].id
  filter_id   = cloudflare_filter.filter[each.value].id
  action      = var.firewall_rule.action
  paused      = var.firewall_rule.paused
  description = var.firewall_rule.description
  priority    = var.firewall_rule.priority
  products    = var.firewall_rule.action == "bypass" ? var.firewall_rule.bypass : null
}
