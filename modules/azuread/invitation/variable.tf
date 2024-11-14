####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "invitation" {
  description = <<-EOF
    'var.invitation' is the main variable for azuread_invitation resource settings.
  EOF
  type        = object({
    user_display_name   = string
    user_email_address  = string
    redirect_url        = optional(string, "https://microsoft365.com")
    user_type           = optional(string, null)
    message             = optional(object({
      enabled               = optional(bool, true)
      additional_recipients = optional(list(string), null)
      body                  = optional(string, null)
      language              = optional(string, null)
    }), { enabled = false })
  })
  validation {
    condition     = can(length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.invitation.user_email_address)) > 0)
    error_message = <<-EOF
      Value for 'var.invitation.user_email_address' is invalid: ${var.invitation.user_email_address}
      Must be:
        RFC 5322 compliant email address
    EOF
  }
  validation {
    condition     = var.invitation.user_type == null ? true : contains(["Guest", "Member"], var.invitation.user_type)
    error_message = <<-EOF
      Value for 'var.invitation.user_type' is invalid: ${var.invitation.user_type == null ? 0 : var.invitation.user_type}
      Must be one of:
        "Guest", "Member" or null
    EOF
  }
}
