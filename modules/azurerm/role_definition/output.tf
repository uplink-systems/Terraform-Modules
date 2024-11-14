####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "azurerm_role_definition" {
  description   = "list of all exported attributes values from the azurerm_role_definition resources"
  value         = azurerm_role_definition.role_definition
}

output "azurerm_role_definition_role_definition_id" {
  description   = "list of role_definitions_id attribute values from the azurerm_role_definition resources"
  value         = azurerm_role_definition.role_definition.role_definition_id
}
