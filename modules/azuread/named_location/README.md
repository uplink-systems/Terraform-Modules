## Module 'named_location'

### Description

This module is intended to create named locations in Azure AD. The module scopes all types of location (Country-based/IP-based) in one resource depending on the variable values provided.

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [hashicorpe\/azuread](#requirement\_azuread) | ~> 3.0 |

### Resources

| Name | Type |
|------|------|
| [azuread_named_location.named_location](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/named_location) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_named_location"></a> [named\_location](#input\_named\_location) | 'var.named_location' is the main variable for azuread_named_location resource settings | <pre>type        = object({<br>  display_name  = string<br>  country       = optional(object({<br>    enabled                               = optional(bool, true)<br>    countries_and_regions                 = optional(list(string), [])<br>    include_unknown_countries_and_regions = optional(bool, false)<br>  }), { enabled = false })<br>  ip            = optional(object({<br>    enabled                               = optional(bool, true)<br>    ip_ranges                             = optional(list(string), [])<br>    trusted                               = optional(bool, false)<br>  }), { enabled = false})<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azuread_named_location"></a> [azuread\_named\_location](#output\_azuread\_named\_location) | list of all exported attributes values from all named locations |
| <a name="output_azuread_named_location_user_id"></a> [azuread\_named\_location\_id](#output\_azuread\_named\_location\_id) | list of exported id attribute values from all named locations |

<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - IDs of all named location ids using 'azuread_named_location_ids' output:  

```
output "azuread_named_location_id_all_locations" {
    value = toset([
        for id in module.azuread_named_location : id.azuread_named_location_ids
    ])
}
```
</details>

### Known Issues

<details>
<summary><b>n/a</b></summary>

######
  
</details>
  
## Notes

### Variables / Locals

#### 'var.named_location.country.countries_and_regions'

The variable *var.named_location.country.countries_and_regions* represents a list of one or more countries specified by 2-digit country codes.  

#### 'var.named_location.ip.ip_ranges'

The variable *var.named_location.ip.ip_ranges* represents a list of one or more IPv4 and/or IPv6 IP-address ranges.  
  
---
  
[Back to README.md](../README.md)  