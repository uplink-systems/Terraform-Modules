####################################################################################################
#   outputs.tf                                                                                     #
####################################################################################################

# Output 'azuread_group'
output "azuread_group" {
    value         = azuread_group.group[*]
    description   = "List of all exported attributes values from all azuread_group resources"
}

# Output 'azuread_group_display_names'
output "azuread_group_display_names" {
    value         = azuread_group.group[*].display_name
    description   = "List of display_name attribute values from azuread_group resources"
}

# Output 'azuread_group_object_ids'
output "azuread_group_object_ids" {
    value         = azuread_group.group[*].object_id
    description   = "List of object_id attribute values from azuread_group resources"
}
