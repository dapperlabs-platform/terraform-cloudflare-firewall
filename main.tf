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
      action      = firewall_rules.value.action
      expression  = firewall_rules.value.expression
      description = firewall_rules.value.description
      enabled     = firewall_rules.value.enabled
      dynamic "action_parameters" {
        for_each = rules.value.action == "skip" ? [] : [rules.value.action_parameters]
        content {
          phases = action_parameters.value.phases
        }
      }
    }
  }
}
