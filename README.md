# Cloudflare-Firewall Module

https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule

## What does this do?

This module allows you to create a CF Custom Ruleset and define custom rules

## How to use this module?

To set the order of the rules add the order number to the begining of the rule name or it will terraform will order alphabetically.
Terraform uses lexical sorting which will overide CloudFlare's typelist ordering when used as a module.

```hcl
module "custom_firewall_rules" {

  source = "github.com/dapperlabs-platform/terraform-cloudflare-firewall?ref=tag"

domains = var.domains

  firewall_rule = {

  "1_block_threat_40" = {
      description = "Block Threat Score > 40"
      expression  = "(cf.threat_score ge 40)"
      action      = "block"
      enabled     = true
  },
  "2_bypass_managed_WAF_rules" = {
      description = "Bypass managed WAF rules for trusted networks",
      expression  = <<EOT
      http.host contains "api.some.domain.com" and ip.src in $general_list
      EOT
      action      = "skip"
      enabled     = true
      phases      = ["http_request_firewall_managed", ]
    },
  }
}

terraform {

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.2.0"
    }
  }s
}
```

## Required Providers

| NAME                  | VERSION CONSTRAINTS |
| --------------------- | ------------------- |
| cloudflare/cloudflare | ~> 4.1           |

| name                | description                                                                             |             type              | required | default |
| ------------------- | --------------------------------------------------------------------------------------- | :---------------------------: | :------: | :-----: |
| Domain              | (Required) Cloudflare Domain to be applied to                                           | <code title="">list</code>    |    ✓     |         |
| description         | (Required) Name and description of the rule                                             | <code title="">string</code>  |    ✓     |         |
| expression          | (Required) Firewall Rules expression language to target the rule                        | <code title="">string</code>  |    ✓     |         |
| action              | (Required) Block, skip, log, challenge, js_challenge, managed_challenge                 | <code title="">string</code>  |    ✓     |         |
| enabled             | (Required)Turn ON/OFF Rate Limiting Rule                                                | <code title="">bool</code>    |    ✓     |         |
| logging             | (For Skip Only)How Cloudflare tracks the request rate for this rule.                    | <code title="">list</code>    |          |  true   |
| ruleset             | (For Skip Only)Which ruleset to skip.                                                   | <code title="">list</code>    |          |         |
| phases              | (For Skip Only)Which phase the rule should skip.                                        | <code title="">list</code>    |          |         |
