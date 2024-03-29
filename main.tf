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

  dynamic "rules" {
    for_each = var.firewall_rules
    content {
      description = rules.value.description
      expression  = rules.value.expression
      action      = rules.value.action
      enabled     = rules.value.enabled

      dynamic "logging" {
        for_each = rules.value.action == "skip" ? [1] : []
        content {
          enabled = rules.value.logging
        }
      }

      dynamic "action_parameters" {
        for_each = rules.value.action == "skip" ? [1] : []
        content {
          ruleset = rules.value.ruleset
          phases  = rules.value.phases
        }
      }
    }
  }
}
