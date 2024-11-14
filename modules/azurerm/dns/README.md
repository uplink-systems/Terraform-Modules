## Module 'dns'

### Description

This module is intended to create public DNS zones and resource record sets in Azure RM. The module only manages forward lookup zones. Reverse lookup zones are currently not in scope of this module.  
  
For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azurerm/dns

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

### Resources

| Name | Type |
|------|------|
| [azurerm_dns_zone.zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_zone"></a> [zone](#input\_zone) | 'var.zone' is the main variable for azurerm_dns zone resource attributes | <pre>type = object({<br>  name                = string<br>  resource_group_name = string<br>  tags                = optional(map(string))<br>})<br></pre> | none | yes |
| <a name="input_recordset"></a> [recordset](#input\_recordset) | 'var.recordset' is the main variable for azurerm_dns recordset resource attributes and can contain all types of recordsets that can be managed via Terraform | <pre>type        = object({<br>  a           = optional(map(object({<br>    name        = string<br>    records     = list(string)<br>    ttl         = optional(number, 3600)<br>  })), {})<br>  aaaa        = optional(map(object({<br>    name        = string<br>    records     = list(string)<br>    ttl         = optional(number, 3600)<br>  })), {})<br>  caa         = optional(map(object({<br>    name        = string<br>    record      = list(string)<br>    ttl         = optional(number, 3600)<br>  })), {})<br>  cname       = optional(map(object({<br>    name        = string<br>    record      = string<br>    ttl         = optional(number, 3600)<br>  })), {})<br>  mx          = optional(map(object({<br>    name        = string<br>    record      = list(string)<br>    ttl         = optional(number, 3600)<br>  })), {})<br>  ns          = optional(map(object({<br>    name        = string<br>    records     = list(string)<br>    ttl         = optional(number, 172800)<br>  })), {})<br>  srv         = optional(map(object({<br>    name        = string<br>    record      = list(string)<br>    ttl         = optional(number, 3600)<br>  })), {})<br>  txt         = optional(map(object({<br>    name        = string<br>    record      = list(string)<br>    ttl         = optional(number, 3600)<br>  })), {})<br>})<br></pre> | {} | no |
  
<details>
<summary><b>Using the variables in the root module</b></summary>
  
The following lines explain how the main variable in the root module has to be defined with minimum required settings if the module is used with a for_each loop and shall create multiple resources:  

<pre>
variable "azurerm_dns" {
  type  = map(object({
    zone      = any
    recordset = optional(any, {})
  }))
}
module "azurerm_dns" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azurerm/dns"
  for_each              = var.azurerm_dns
  zone                  = each.value.zone
  recordset             = each.value.recordset
}
</pre>

</details>
  
### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_dns_zone"></a> [azurerm\_dns\_zone](#output\_azurerm\_dns\_zone) | list of all exported attributes values from the DNS zone |
| <a name="output_azurerm_dns_zone_id"></a> [azurerm\_dns\_zone\_id](#output\_azurerm\_dns\_zone\_) | list of exported id attribute values from the DNS zone |
| <a name="output_azurerm_dns_zone_name_servers"></a> [azurerm\_dns\_zone\_name\_servers](#output\_azurerm\_dns\_zone\_name\_servers) | list of exported name_servers attribute values from the DNS zone |
| <a name="output_azurerm_dns_zone_number_of_record_sets"></a> [azurerm\_dns\_zone\_number\_of\_record\_sets](#output\_azurerm\_dns\_zone\_number\_of\_record\_sets) | list of exported number_of_record_sets attribute values from the DNS zone |

  
The module is planned to generate the following outputs for the DNS recordsets (development in progress):  
  
| Name | Description |
|------|-------------|
| <a name="output_azurerm_dns_a_record"></a> [azurerm\_dns\_a\_record](#output\_azurerm\_dns\_a\_record) | list of all exported attributes values from the DNS A record sets  |
| <a name="output_azurerm_dns_aaaa_record"></a> [azurerm\_dns\_aaaa\_record](#output\_azurerm\_dns\_aaaa\_record) | list of all exported attributes values from the DNS AAAA record sets  |
| <a name="output_azurerm_dns_caa_record"></a> [azurerm\_dns\_caa\_record](#output\_azurerm\_dns\_caa\_record) | list of all exported attributes values from the DNS CAA record sets  |
| <a name="output_azurerm_dns_cname_record"></a> [azurerm\_dns\_cname\_record](#output\_azurerm\_dns\_cname\_record) | list of all exported attributes values from the DNS CNAME record sets  |
| <a name="output_azurerm_dns_mx_record"></a> [azurerm\_dns\_mx\_record](#output\_azurerm\_dns\_mx\_record) | list of all exported attributes values from the DNS MX record sets  |
| <a name="output_azurerm_dns_ns_record"></a> [azurerm\_dns\_ns\_record](#output\_azurerm\_dns\_ns\_record) | list of all exported attributes values from the DNS NS record sets  |
| <a name="output_azurerm_dns_soa_record"></a> [azurerm\_dns\_soa\_record](#output\_azurerm\_dns\_soa\_record) | list of all exported attributes values from the DNS SOA record sets  |
| <a name="output_azurerm_dns_srv_record"></a> [azurerm\_dns\_srv\_record](#output\_azurerm\_dns\_srv\_record) | list of all exported attributes values from the DNS SRV record sets  |
| <a name="output_azurerm_dns_txt_record"></a> [azurerm\_dns\_txt\_record](#output\_azurerm\_dns\_txt\_record) | list of all exported attributes values from the DNS TXT record sets  |
| <a name="output_azurerm_dns_a_record_id"></a> [azurerm\_dns\_a\_record\_id](#output\_azurerm\_dns\_a\_record\_id) | list of exported id attribute values from the DNS A record sets  |
| <a name="output_azurerm_dns_aaaa_record_id"></a> [azurerm\_dns\_aaaa\_record\_id](#output\_azurerm\_dns\_aaaa\_record\_id) | list of exported id attribute values from the DNS AAAA record sets |
| <a name="output_azurerm_dns_caa_record_id"></a> [azurerm\_dns\_caa\_record\_id](#output\_azurerm\_dns\_caa\_record\_id) | list of exported id attribute values from the DNS CAA record sets |
| <a name="output_azurerm_dns_cname_record_id"></a> [azurerm\_dns\_cname\_record\_id](#output\_azurerm\_dns\_cname\_record\_id) | list of exported id attribute values from the DNS CNAME record sets |
| <a name="output_azurerm_dns_mx_record_id"></a> [azurerm\_dns\_mx\_record\_id](#output\_azurerm\_dns\_mx\_record\_id) | list of exported id attribute values from the DNS MX record sets |
| <a name="output_azurerm_dns_ns_record_id"></a> [azurerm\_dns\_ns\_record\_id](#output\_azurerm\_dns\_ns\_record\_id) | list of exported id attribute values from the DNS NS record sets |
| <a name="output_azurerm_dns_soa_record_id"></a> [azurerm\_dns\_soa\_record\_id](#output\_azurerm\_dns\_soa\_record\_id) | list of exported id attribute values from the DNS SOA record sets |
| <a name="output_azurerm_dns_srv_record_id"></a> [azurerm\_dns\_srv\_record\_id](#output\_azurerm\_dns\_srv\_record\_id) | list of exported id attribute values from the DNS SRV record sets |
| <a name="output_azurerm_dns_txt_record_id"></a> [azurerm\_dns\_txt\_record\_id](#output\_azurerm\_dns\_txt\_record\_id) | list of exported id attribute values from the DNS TXT record sets |
  
<details>

<summary><b>Using the outputs in the root module</b</summary>

#### Examples

Output - IDs of all groups using 'azurerm_dns_zone' output:

<pre>
output "azurerm_dns_zone_id_all_groups" {
    value = toset([
        for object_id in module.azurerm_dns : object_id.azurerm_dns_zone_id
    ])
}
</pre>

...or directly via 'azurerm_dns_zone_id' output:

<pre>
output "azurerm_dns_zone_id_all_groups" {
    value = values(module.azurerm_dns).*.azurerm_dns_zone_id
}

</pre>

Output - ID of a single specified group using 'azurerm_dns_zone_id' output:

<pre>
output "azurerm_dns_zone_id_group_1" {
    value = module.azurerm_dns["<i>&lt;Terraform-Resource-Name&gt;</i>"].azurerm_dns_zone_id
}
</pre>

</details>

### Known Issues

n/a
  
---
  
[Back to README.md](../README.md)  
