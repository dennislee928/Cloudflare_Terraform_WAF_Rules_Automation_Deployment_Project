# Cloudflare Terraform Module

This module helps you manage Cloudflare resources including zones, DNS records, and WAF rules.

## Usage

```hcl
module "cloudflare" {
  source = "github.com/[your-username]/[repo-name]"

  cloudflare_api_token = var.cloudflare_api_token
  account_id          = var.account_id
  zone_names          = ["example.com"]
  plan                = "free"
  dns_records = {
    "example.com" = [
      {
        type  = "A"
        name  = "@"
        value = "1.2.3.4"
        ttl   = 1
      }
    ]
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| cloudflare | ~> 4.10.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| cloudflare_api_token | Cloudflare API token | string | yes |
| account_id | Cloudflare account ID | string | yes |
| zone_names | List of zone names | list(string) | yes |
| plan | Cloudflare plan for the zone | string | yes |
| dns_records | DNS records for each zone | map(list(object)) | yes |

## Outputs

| Name | Description |
|------|-------------|
| zone_ids | The IDs of the created zones |
