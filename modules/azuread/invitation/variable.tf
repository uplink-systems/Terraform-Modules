####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "user_display_name" {
  description = "Guest's display name"
}
variable "user_email_address" {
  description = "Guest's email address"
}
variable "message" {
  description = "Invitation message parameter"
}
variable "redirect_url" {
  description = "Redirect URL for the guest user"
}
variable "user_type" {
  description = "Guest's type of user (Guest or Member)"
  validation {
    condition     = (
      var.user_type == null ? true : contains(["Guest", "Member"], var.user_type)
    )
    error_message = <<-EOF
      Variable 'user_type' has an invalid value: ${var.user_type == null ? 0 : var.user_type}
      Value must be one of:
        "Guest", "Member" or null
    EOF
  } 
}
