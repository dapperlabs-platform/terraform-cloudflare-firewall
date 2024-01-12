# Cloudflare Firewall Rules
# Firewall rules for all Zones Defined
data "cloudflare_zones" "zones" {
  count = length(var.domains)

  filter {
    name        = var.domains[count.index]
    lookup_type = "exact"
    paused      = false
  }
}


resource "cloudflare_ruleset" "zone_level_waf_custom_rules" {
  count = length(var.domains)


  zone_id = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name    = "default"
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  rules {
    action = var.firewall_rule.action
    dynamic "action_parameters" {
      for_each = var.ruleset_id == null ? [] : [1]
      content {
        ruleset = var.ruleset_id
        version = "current"
      }
    }
    expression  = var.firewall_rule.expression
    description = var.firewall_rule.description
    enabled     = var.firewall_rule.enabled
  }
}
