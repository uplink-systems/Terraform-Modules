####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuredevops_user_entitlement" "user_entitlement" {
  for_each              = data.azuread_user.user
  principal_name        = each.value.user_principal_name
  account_license_type  = var.user_entitlement.account_license_type
  licensing_source      = var.user_entitlement.licensing_source
}
