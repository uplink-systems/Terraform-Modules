####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "azurerm_dns_zone_ids" {
    value = values(module.azurerm_dns).*.azurerm_dns_zone_id
}

output "azurerm_dns_zone_ids_toset" {
    value = toset([ for object_id in module.azurerm_dns : object_id.azurerm_dns_zone_id ])
}
