####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# This is used to get the configuration for the user or group that deploys this code 
data "azuread_client_config" "current" {}

# This is used to get user object ids for each owner by user principal name list from variable...
data "azuread_users" "owners" {
  user_principal_names      = var.owners
}

# This is used to get user object ids for each member by user principal name list from variable...
data "azuread_users" "members" {
  user_principal_names      = var.member_users
}

# This is used to get group object ids for each member by group name list from variable...
data "azuread_groups" "members" {
  display_names             = var.member_groups
}

# This is used to get administrative unit object ids for each administrative unit name in the variable list...
data "azuread_administrative_unit" "administrative_unit" {
  for_each       = {for k,v in coalesce(var.administrative_units, []) : k=>v}
  display_name    = each.value
}
