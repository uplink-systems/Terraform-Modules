####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# This is used to output the Azure managed NS root record set
data "azurerm_dns_ns_record" "recordset" {
  name                  = "@"
  zone_name             = var.name
  resource_group_name   = var.resource_group_name
  depends_on            = [ azurerm_dns_zone.zone ]
}

# This is used to output the Azure managed SOA record set
data "azurerm_dns_soa_record" "recordset" {
  zone_name             = var.name
  resource_group_name   = var.resource_group_name
  depends_on            = [ azurerm_dns_zone.zone ]
}
