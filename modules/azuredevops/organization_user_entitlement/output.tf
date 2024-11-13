####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "user_entitlement" {
  description = "user_entitlement resource attributes"
  value       = azuredevops_user_entitlement.user_entitlement
}

output "user_entitlement_user" {
  description = "user_entitlement resource entitled user display names"
  value       = {
    for user in data.azuread_user.user : user.id => user.display_name
  }
}
