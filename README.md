# Cloudflare-Firewall Module

https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule

## What does this do?

This module allows you to create a CF Firewall rule uses filter expressions for controlling how traffic is matched to the rule. 

## How to use this module?

```hcl
module "block_threat" {

  source = "github.com/dapperlabs-platform/terraform-cloudflare-firewall?ref=tag"

  firewall_rule = {

    description = "Block Threat Score > 40"
    expression  = "(cf.threat_score ge 40)"
    action      = "block"
    paused      = false
    bypass      = null
    priority    = null

  }

  domains = var.domains
}

terraform {

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.25.0"
    }
  }
}
```

## Required Providers

|         NAME          | VERSION CONSTRAINTS |
|-----------------------|---------------------|
| cloudflare/cloudflare | ~> 2.18.0             |

| name | description | type | required | default |
|---|---|:---: |:---:|:---:|
| firewall_rule | (Required) The action to apply to a matched request. Allowed values: "block", "challenge", "allow", "js_challenge", "bypass". Enterprise plan also allows "log". | <code title="">string</code> | ✓ |  |
| domains | (Required) The DNS zone to which the Filter should be added.  | <code title="">string</code> | ✓ |  |
