####################################################################################################
#   Azure AD: Groups (Security/Assigned, Security/Dynamic, Unified/Assigned, Unified/Dynamic)      #
####################################################################################################

resource "azuread_group" "group" {
  display_name                = var.display_name
  description                 = var.description
  administrative_unit_ids     = length(local.administrative_unit_ids) > 0 ? local.administrative_unit_ids : null
  assignable_to_role          = var.assignable_to_role
  auto_subscribe_new_members  = var.auto_subscribe_new_members
  behaviors                   = var.behaviors
  external_senders_allowed    = var.external_senders_allowed
  hide_from_address_lists     = var.hide_from_address_lists
  hide_from_outlook_clients   = var.hide_from_outlook_clients
  mail_enabled                = var.mail_enabled
  mail_nickname               = var.mail_nickname == null ? var.display_name : var.mail_nickname
  members                     = length(local.members) > 0 ? local.members : null
  onpremises_group_type       = var.writeback_enabled == true ? var.onpremises_group_type : null
  owners                      = data.azuread_users.owners.object_ids != null ? null : data.azuread_users.owners.object_ids
  prevent_duplicate_names     = var.prevent_duplicate_names
  provisioning_options        = var.provisioning_options
  security_enabled            = var.security_enabled
  theme                       = var.theme
  visibility                  = var.visibility
  writeback_enabled           = var.writeback_enabled
  types                       = var.types
  dynamic "dynamic_membership" {
    for_each = var.dynamic_membership != null ? [var.dynamic_membership] : []
    content {
      enabled = var.dynamic_membership.enabled
      rule    = var.dynamic_membership.rule
    }
  }
  lifecycle {
    ignore_changes  = [ administrative_unit_ids, behaviors ]
  }
}
