####################################################################################################
#   outputs.tf                                                                                     #
####################################################################################################

output "azuread_invitation" {
    value         = azuread_invitation.invitation[*]
    description   = "List of all exported attributes values from all azuread_invitation resources"
}

output "azuread_invitation_user_id" {
    value         = azuread_invitation.invitation[*].user_id
    description   = "List of user_id attribute values from azuread_invitation resources"
}