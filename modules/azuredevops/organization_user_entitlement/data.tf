####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# get attributes from Azure AD group list
data "azuread_group" "group" {
  for_each              = toset(var.azuread_groups)
  display_name          = each.value
}

# get users from flattened group members list
data "azuread_user" "user" {
  for_each              = { for user in local.azuread_group_members : user.item => user }
  object_id             = each.value.item
}