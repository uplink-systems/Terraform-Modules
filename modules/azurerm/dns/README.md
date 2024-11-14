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

#### Using the variables in the root module

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

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_dns_zone"></a> [azurerm\_dns\_zone](#output\_azurerm\_dns\_zone) | list of all exported attributes values from the DNS zone |
| <a name="output_azurerm_dns_zone_id"></a> [azurerm\_dns\_zone\_id](#output\_azurerm\_dns\_zone\_) | list of exported id attribute values from the DNS zone |
| <a name="output_azurerm_dns_zone_name_servers"></a> [azurerm\_dns\_zone\_name\_servers](#output\_azurerm\_dns\_zone\_name\_servers) | list of exported name_servers attribute values from the DNS zone |
| <a name="output_azurerm_dns_zone_number_of_record_sets"></a> [azurerm\_dns\_zone\_number\_of\_record\_sets](#output\_azurerm\_dns\_zone\_number\_of\_record\_sets) | list of exported number_of_record_sets attribute values from the DNS zone |

  
The module is planned to generate the following outputs for the DNS recordsets (development in progress):  
1) <b>azurerm_dns_a_record</b>          => list of all exported attributes values from all DNS A record sets  
2) <b>azurerm_dns_aaaa_record</b>       => list of all exported attributes values from all DNS AAA record sets  
3) <b>azurerm_dns_caa_record</b>        => list of all exported attributes values from all DNS CAA record sets  
4) <b>azurerm_dns_cname_record</b>      => list of all exported attributes values from all DNS CNAME record sets  
5) <b>azurerm_dns_mx_record</b>         => list of all exported attributes values from all DNS MX record sets  
6) <b>azurerm_dns_ns_record</b>         => list of all exported attributes values from all DNS NS record sets  
7) <b>azurerm_dns_soa_record</b>        => list of all exported attributes values from all DNS SOA record sets  
8) <b>azurerm_dns_srv_record</b>        => list of all exported attributes values from all DNS SRV record sets  
9) <b>azurerm_dns_txt_record</b>       => list of all exported attributes values from all DNS TXT record sets  
10) <b>azurerm_dns_a_record_id</b>      => list of exported id attribute values from all DNS A record sets  
11) <b>azurerm_dns_aaaa_record_id</b>   => list of exported id attribute values from all DNS AAA record sets  
12) <b>azurerm_dns_caa_record_id</b>    => list of exported id attribute values from all DNS CAA record sets  
13) <b>azurerm_dns_cname_record_id</b>  => list of exported id attribute values from all NS CNAME record sets  
14) <b>azurerm_dns_mx_record_id</b>     => list of exported id attribute values from all DNS MX record sets  
15) <b>azurerm_dns_ns_record_id</b>     => list of exported id attribute values from all DNS NS record sets  
16) <b>azurerm_dns_soa_record_id</b>    => list of exported id attribute values from all DNS SOA record sets  
17) <b>azurerm_dns_srv_record_id</b>    => list of exported id attribute values from all DNS SRV record sets  
18) <b>azurerm_dns_txt_record_id</b>    => list of exported id attribute values from all DNS TXT record sets  
  
#### Using module output in root module

##### Examples

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

### Known Issues

The module is affected by the following known issues:

n/a
  
---
  
[Back to README.md](../README.md)  
