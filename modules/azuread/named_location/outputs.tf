####################################################################################################
#   outputs.tf                                                                                     #
####################################################################################################

output "azuread_named_location" {
    value = azuread_named_location.named_location
    description   = "List of all exported attributes values from all azuread_named_location resources"
}

output "azuread_named_location_id" {
    value         = azuread_named_location.named_location.id
    description   = "List of id attribute values from azuread_named_location resources"
}
