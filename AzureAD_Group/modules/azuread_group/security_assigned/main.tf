####################################################################################################
#   Azure AD assigned membership security groups                                                   #
####################################################################################################

# get user object ids for each member by user principal name list from variable...
data "azuread_users" "security_assigned_members" {
  user_principal_names    = var.member_users
}

# get group object ids for each member by group name list from variable...
data "azuread_groups" "security_assigned_members" {
  display_names           = var.member_groups
}

# get user object ids for each owner by user principal name list from variable...
data "azuread_users" "security_assigned_owners" {
  user_principal_names    = var.owners
}

# create resource for each group and add members/owners by queried object ids...
resource "azuread_group" "security_assigned" {
  display_name            = var.display_name
  description             = var.description
  administrative_unit_ids = var.administrative_unit_ids
  assignable_to_role      = var.assignable_to_role
  mail_enabled            = false
  members                 = concat(data.azuread_users.security_assigned_members.object_ids,data.azuread_groups.security_assigned_members.object_ids)
  owners                  = data.azuread_users.security_assigned_owners.object_ids != null ? null : data.azuread_users.security_assigned_owners.object_ids
  prevent_duplicate_names = var.prevent_duplicate_names
  security_enabled        = var.security_enabled
}
