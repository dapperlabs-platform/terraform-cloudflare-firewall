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
  zone_id = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name    = "default"
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  for_each = var.firewall_rules
  rules {
    action      = firewall_rules.value.action
    expression  = firewall_rules.value.expression
    description = firewall_rules.value.description
    enabled     = firewall_rules.value.enabled

    dynamic "action_parameters" {
      for_each = firewall_rules.value.action == "skip" ? [1] : [0]
      content {
        phases = firewall_rules.value.phases
      }
    }
  }
}
