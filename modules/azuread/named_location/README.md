## README

### Purpose

This module is intended to create named locations in Azure AD. The module scopes all types of location (Country-based/IP-based) in one resource depending on the variable values provided.

### Example

For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuread/named_location  

### Versions

This module was tested with the following Terraform and provider versions before release:

<pre>
terraform {
  required_version = "= 1.9.6"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 3.0.2"
    }
  }
}
</pre>

Other version might work but are not tested by the developer of the module.

### Files

n/a

### Variables

#### 'var.named_location.country.countries_and_regions'

The variable <i>var.named_location.country.countries_and_regions</i> represents a list of one or more countries specified by 2-digit country codes.  

#### 'var.named_location.ip.ip_ranges'

The variable <i>var.named_location.ip.ip_ranges</i> represents a list of one or more IPv4 and/or IPv6 IP-address ranges.  

### Outputs

The module currently generates the following outputs:  
1) <b>azuread_named_location</b> => list of all exported attributes values from all named locations  
2) <b>azuread_named_location_id</b> => list of exported id attribute values from all named locations  

#### Using module output in root module

##### Examples

Output - IDs of all named location ids using 'azuread_named_location_ids' output:  

<pre>
output "azuread_named_location_id_all_locations" {
    value = toset([
        for id in module.azuread_named_location : id.azuread_named_location_ids
    ])
}
</pre>

### Known Issues

The module is affected by the following known issues:  

n/a
