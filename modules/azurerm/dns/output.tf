####################################################################################################
#   output.tf                                                                                      #
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
