####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "group" {
  description = <<-EOF
    'var.group' is the main variable for azuread_group resource settings.
  EOF
  type        = object({
    display_name                = string
    administrative_units        = optional(set(string), null)
    assignable_to_role          = optional(bool, false)
    auto_subscribe_new_members  = optional(bool, false)
    behaviors                   = optional(set(string), null)
    description                 = optional(string)
    dynamic_membership          = optional(object({
      enabled                     = optional(bool, true)
      rule                        = optional(string, null)
    }), { enabled = false })
    mail                        = optional(object({
      mail_enabled                = optional(bool, true)
      mail_nickname               = optional(string, null)
      external_senders_allowed    = optional(bool, false)
      hide_from_address_lists     = optional(bool, false)
      hide_from_outlook_clients   = optional(bool, false)
    }), { mail_enabled = false })
    members                     = optional(object({
      enabled                     = optional(bool, true)
      group                       = optional(set(string), [])
      service_principal           = optional(set(string), [])
      user                        = optional(set(string), [])
    }), { enabled = false })
    owners                      = optional(set(string), [])
    prevent_duplicate_names     = optional(bool, true)
    provisioning_options        = optional(set(string), null)
    security_enabled            = optional(bool, true)
    theme                       = optional(string, null)
    types                       = optional(list(string), null)
    visibility                  = optional(string, null)
    writeback                   = optional(object({
      writeback_enabled           = optional(bool, true)
      onpremises_group_type       = optional(string, "UniversalSecurityGroup")
    }), { writeback_enabled = false })
  })
  # Variable attributes' validation rules
  validation {
    condition     = (
      var.group.provisioning_options == null ? true : contains(["Team"], (join(",", var.group.provisioning_options)))
    )
    error_message = <<-EOF
      Variable attribute 'provisioning_options' has an invalid value: ${var.group.provisioning_options == null ? 0 : (join(",", var.group.provisioning_options))}
      Value must be one of:
        "Team" or null
    EOF
  }
  validation {
    condition     = (
      var.group.theme == null ? true : contains(["Blue", "Green", "Orange", "Pink", "Purple", "Red", "Teal"], var.group.theme)
    )
    error_message = <<-EOF
      Variable attribute 'theme' has an invalid value: ${var.group.theme == null ? 0 : var.group.theme}
      Value must be one of:
        "Blue", "Green", "Orange", "Pink", "Purple", "Red", "Teal" or null
    EOF
  }
  validation {
    condition     = (
      var.group.visibility == null ? true : contains(["Private", "Public", "Hiddenmembership"], var.group.visibility)
    )
    error_message = <<-EOF
      Variable attribute 'visibility' has an invalid value: ${var.group.visibility == null ? 0 : var.group.visibility}
      Value must be one of:
        "Private", "Public", "Hiddenmembership" (Unified groups only!) or null
    EOF
  }
}