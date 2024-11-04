####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "azurerm_dns_zone" {
  description = "List of all exported attributes values from the DNS zone"
  value       = azurerm_dns_zone.zone
}

output "azurerm_dns_zone_id" {
  description = "List of exported 'id' attribute values from the DNS zone"
  value       = azurerm_dns_zone.zone.id
}

output "azurerm_dns_zone_name" {
  description = "List of exported 'name' attribute values from the DNS zone"
  value       = azurerm_dns_zone.zone.name
}

output "azurerm_dns_zone_name_servers" {
  description = "List of exported 'name_servers' attribute values from the DNS zone"
  value       = azurerm_dns_zone.zone.name_servers
}

output "azurerm_dns_zone_number_of_record_sets" {
  description = "List of exported 'number_of_record_sets' attribute values from the DNS zone"
  value       = azurerm_dns_zone.zone.number_of_record_sets
}
