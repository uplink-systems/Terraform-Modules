####################################################################################################
#   outputs.tf                                                                                     #
####################################################################################################

output "azurerm_role_definition" {
    value         = azurerm_role_definition.role_definition
    description   = "List of all exported attributes values from all azurerm_role_definition resources"
}

output "azurerm_role_definition_role_definition_id" {
    value         = azurerm_role_definition.role_definition.role_definition_id
    description   = "List of role_definitions_id attribute values from zurerm_role_definition resources"
}
