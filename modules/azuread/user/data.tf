####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# domains for UPN-/mail-suffix
data "azuread_domains" "initial" { only_initial = true }  # Microsoft assigned tenant domain (onmicrosoft.com domain)
data "azuread_domains" "default" { only_default = true }  # Default domain (depends on Tenant config: either custom domain or Microsoft assigned tenant domain)

# get the object ID from manager's UPN
data "azuread_user" "manager_id" {
  count                 = var.user.manager_id == null ? 0 : 1
  user_principal_name   = var.user.manager_id
}

# get the object IDs from sponsors' UPNs
data "azuread_users" "sponsors" {
  user_principal_names  = var.user.sponsors
}