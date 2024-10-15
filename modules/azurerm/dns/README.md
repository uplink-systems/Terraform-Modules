## Module Description

### Purpose

This module is intended to create public DNS zones and resource record sets in Azure RM. The module only manages forward lookup zones. Reverse lookup zones are currently not in scope of this module.  

### Example

For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azurerm/dns

### Versions

This module was tested with the following Terraform and provider versions before release:

<pre>
terraform {
  required_version = "= 1.9.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.116.0"
    }
  }
}
</pre>

Other version might work but are not tested by the developer of the module.

### Files

n/a  

### Variables

#### 'name'

The variable <i>name</i> represents the DNS zone's name.

#### 'recordset_XXX'

The variables <i>recordset_XXX</i> (where 'XXX' is a placeholder for the recordset type) represent the recordsets for the corresponding DNS zone.  

### Outputs

The module currently generates the following outputs for the DNS zones:  
1) <b>azurerm_dns_zone</b> => list of all exported attributes values from all DNS zones  
2) <b>azurerm_dns_zone_id</b> => list of exported id attribute values from all DNS zones   
3) <b>azurerm_dns_zone_name_servers</b> => list of exported name_servers attribute values from all DNS zones  
4) <b>azurerm_dns_zone_number_of_record_sets</b> => list of exported number_of_record_sets attribute values from all DNS zones  
  
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
