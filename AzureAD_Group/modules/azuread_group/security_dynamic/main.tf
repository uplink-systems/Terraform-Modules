####################################################################################################
#   Azure AD dynamic membership security groups                                                    #
####################################################################################################

# get user object ids for each owner by user principal name list from variable...
data "azuread_users" "security_dynamic_owners" {
  user_principal_names    = var.owners
}

# create resource for each group with rule and add owners by queried object ids...
resource "azuread_group" "security_dynamic" {
  display_name            = var.display_name
  description             = var.description
  administrative_unit_ids = var.administrative_unit_ids
  assignable_to_role      = var.assignable_to_role
  owners                  = data.azuread_users.security_dynamic_owners.object_ids != null ? null : data.azuread_users.security_dynamic_owners.object_ids
  prevent_duplicate_names = var.prevent_duplicate_names
  security_enabled        = var.security_enabled
  types                   = [ "DynamicMembership", ]
  dynamic_membership {
    enabled  = true
    rule     = var.rule
  }
}
