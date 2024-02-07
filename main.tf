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
    action      = rules.value.action
    expression  = rules.value.expression
    description = rules.value.description
    enabled     = rules.value
    dynamic "action_parameters" {
      for_each = rules.value.action == "skip" ? [1] : []
      content {
        phases = rules.value.phases
      }
    }
  }
}
