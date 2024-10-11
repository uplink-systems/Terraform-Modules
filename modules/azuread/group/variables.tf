variable "display_name" {
  description = "Group's display name"
}
variable "administrative_units" {
  description = "Display name(s) of adminitrative units"
}
variable "auto_subscribe_new_members" {
  description = "Auto-subscribe new members to receive email notification to the group."
}
variable "assignable_to_role" {
  description = "Can the group be used to assign it to an Entra ID admin role?"
}
variable "behaviors" {
  description = "Behavior of Unified groups: 'AllowOnlyMembersToPost', 'HideGroupInOutlook', 'SkipExchangeInstantOn', 'SubscribeMembersToCalendarEventsDisabled', 'SubscribeNewGroupMembers' and/or 'WelcomeEmailDisabled'"
}
variable "description" {
  description = "Description for the group"
}
variable "dynamic_membership" {
  description = "Group's rule to evaluate for membership assignement"
}
variable "external_senders_allowed" {
  description = "Allow or disallow senders outside the organisation to send mails to the group."
}
variable "hide_from_address_lists" {
  description = "Hide the group from or show the group in the address lists."
}
variable "hide_from_outlook_clients" {
  description = "Hide the group from or show the group in the Outlook clients."
}
variable "mail_enabled" {
  description = "Is the group a mail enabled group?"
}
variable "mail_nickname" {
  description = "Nickname for the mail enabled group"
}
variable "member_groups" {
  description = "Group display name(s) to add as member to the group"
}
variable "member_users" {
    description = "User principal name(s) to add as member to the group"
}
variable "onpremises_group_type" {
  description = "Type of group OnPremises if writeback is enabled to local AD"
}
variable "owners" {
    description = "User principal name(s) to add as owner to the group"
}
variable "prevent_duplicate_names" {
  description = "Prevent duplicate group names"
}
variable "provisioning_options" {
  description = "Provisioning options: 'Team' or default value 'null'"
}
variable "security_enabled" {
  description = "Is the group a security enabled group?"
}
variable "theme" {
  description = "Color theme of the group"
  validation {
    condition     = (
      var.theme == null ? true : contains(["Blue", "Green", "Orange", "Pink", "Purple", "Red", "Teal"], var.theme)
    )
    error_message = "Error: Variable 'theme' has an invalid value. Value must be one of: 'Blue', 'Green', 'Orange', 'Pink', 'Purple', 'Red', 'Teal' or null."
  } 
}
variable "types" {
  description = "Type(s) of the group"
}
variable "visibility" {
  description = "Visibility of the group (Private/Public)"
  validation {
    condition     = (
      var.visibility == null ? true : contains(["Private", "Public", "Hiddenmembership"], var.visibility)
    )
    error_message = "Error: Variable 'visibility' has an invalid value. Value must be one of: 'Private', 'Public', 'Hiddenmembership' (Unified groups only!) or null."
  } 
}
variable "writeback_enabled" {
  description = "Is the group writeback enabled if Azure AD Connect is used to sync local AD?"
}

  