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

# For Geoblocking based on Country Codes
resource "cloudflare_ruleset" "zone_level_geo_blocking" {
  count = length(var.country_block_list) != 0 ? length(var.domains) : 0 # No need to create if country block list is empty

  zone_id = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name    = "Geo Block by Country Code"
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  dynamic "rules" {
    for_each = toset(var.country_block_list)
    content {
      description = "Block traffic from ${rules.value} - Defined via Terraform"
      expression  = "(ip.src.country eq \"${rules.value}\")"
      action      = "block"
      enabled     = true
    }
  }
}
