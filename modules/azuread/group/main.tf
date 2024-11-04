####################################################################################################
#   Azure AD: Groups (Security/Assigned, Security/Dynamic, Unified/Assigned, Unified/Dynamic)      #
####################################################################################################

resource "azuread_group" "group" {
  display_name                = var.group.display_name
  description                 = var.group.description
  administrative_unit_ids     = length(local.administrative_unit_ids) > 0 ? local.administrative_unit_ids : null
  assignable_to_role          = var.group.assignable_to_role
  auto_subscribe_new_members  = var.group.auto_subscribe_new_members
  behaviors                   = var.group.behaviors
  external_senders_allowed    = var.group.mail.external_senders_allowed
  hide_from_address_lists     = var.group.mail.hide_from_address_lists
  hide_from_outlook_clients   = var.group.mail.hide_from_outlook_clients
  mail_enabled                = var.group.mail.mail_enabled
  mail_nickname               = var.group.mail.mail_enabled == false ? null : (var.group.mail.mail_nickname == null ? var.group.display_name : var.group.mail.mail_nickname)
  members                     = length(local.members) > 0 ? local.members : null
  onpremises_group_type       = var.group.writeback.writeback_enabled == true ? var.group.writeback.onpremises_group_type : null
  owners                      = data.azuread_users.owners.object_ids != null ? null : data.azuread_users.owners.object_ids
  prevent_duplicate_names     = var.group.prevent_duplicate_names
  provisioning_options        = var.group.provisioning_options
  security_enabled            = var.group.security_enabled
  theme                       = var.group.theme
  visibility                  = var.group.visibility
  writeback_enabled           = var.group.writeback.writeback_enabled
  types                       = var.group.types
  dynamic "dynamic_membership" {
    for_each = var.group.dynamic_membership.enabled ? [1] : []
    content {
      enabled = var.group.dynamic_membership.enabled
      rule    = var.group.dynamic_membership.rule
    }
  }
  lifecycle {
    ignore_changes  = [ administrative_unit_ids, behaviors ]
  }
}
