####################################################################################################
#   outputs.tf                                                                                     #
####################################################################################################

output "azurerm_dns_zone" {
  value       = azurerm_dns_zone.zone
  description = "List of all exported attributes values from all DNS zones"
}

output "azurerm_dns_zone_id" {
  value       = azurerm_dns_zone.zone.id
  description = "List of exported 'id' attribute values from all DNS zones"
}

output "azurerm_dns_zone_name" {
  value       = azurerm_dns_zone.zone.name
  description = "List of exported 'name' attribute values from all DNS zones"
}

output "azurerm_dns_zone_name_servers" {
  value       = azurerm_dns_zone.zone.name_servers
  description = "List of exported 'name_servers' attribute values from all DNS zones"
}

output "azurerm_dns_zone_number_of_record_sets" {
  value       = azurerm_dns_zone.zone.number_of_record_sets
  description = "List of exported 'number_of_record_sets' attribute values from all DNS zones"
}

output "azurerm_dns_a_record" {
  value       = azurerm_dns_a_record[each.key].recordset
  description = "List of all exported attributes values from all DNS A record sets"
}

output "azurerm_dns_aaaa_record" {
  value       = azurerm_dns_aaaa_record[each.key].recordset
  description = "List of all exported attributes values from all DNS AAA record sets"
}

output "azurerm_dns_caa_record" {
  value       = azurerm_dns_caa_record[each.key].recordset
  description = "List of all exported attributes values from all DNS CAA record sets"
}

output "azurerm_dns_cname_record" {
  value       = azurerm_dns_cname_record[each.key].recordset
  description = "List of all exported attributes values from all DNS CNAME record sets"
}

output "azurerm_dns_mx_record" {
  value       = azurerm_dns_mx_record[each.key].recordset
  description = "List of all exported attributes values from all DNS MX record sets"
}

output "azurerm_dns_ns_record" {
  value       = concat(data.azurerm_dns_ns_record.recordset,azurerm_dns_ns_record[each.key].recordset)
  description = "List of all exported attributes values from all DNS NS root record sets"
}

output "azurerm_dns_soa_record" {
  value       = data.azurerm_dns_soa_record[each.key].recordset
  description = "List of all exported attributes values from all DNS SOA record sets"
}

output "azurerm_dns_srv_record" {
  value       = azurerm_dns_srv_record[each.key].recordset
  description = "List of all exported attributes values from all DNS SRV record sets"
}

output "azurerm_dns_txt_record" {
  value       = azurerm_dns_a_record[each.key].recordset
  description = "List of all exported attributes values from all DNS TXT record sets"
}

output "azurerm_dns_a_record_id" {
  value       = azurerm_dns_a_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS A record sets"
}

output "azurerm_dns_aaaa_record_id" {
  value       = azurerm_dns_aaaa_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS AAA record sets"
}

output "azurerm_dns_caa_record_id" {
  value       = azurerm_dns_caa_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS CAA record sets"
}

output "azurerm_dns_cname_record_id" {
  value       = azurerm_dns_cname_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS CNAME record sets"
}

output "azurerm_dns_mx_record_id" {
  value       = azurerm_dns_mx_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS MX record sets"
}

output "azurerm_dns_ns_record_id" {
  value       = concat(data.azurerm_dns_ns_record.recordset.id,azurerm_dns_ns_record.recordset[each.key].id)
  description = "List of exported id attribute values from all DNS NS root record sets"
}

output "azurerm_dns_soa_record_id" {
  value       = data.azurerm_dns_soa_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS SOA record sets"
}

output "azurerm_dns_srv_record_id" {
  value       = azurerm_dns_srv_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS SRV record sets"
}

output "azurerm_dns_txt_record_id" {
  value       = azurerm_dns_a_record.recordset[each.key].id
  description = "List of exported id attribute values from all DNS TXT record sets"
}
