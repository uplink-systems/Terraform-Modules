####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "user_entitlement" {
  description   = "user_entitlement main variable with resource attributes"
  type          = object({
    account_license_type  = optional(string, "basic")
    licensing_source      = optional(string, null)
  })
  default = {
    account_license_type  = "basic"
  }
  validation {
    condition     = var.user_entitlement.account_license_type == null ? true : contains(["basic", "stakeholder", "advanced", "express", "none"], var.user_entitlement.account_license_type)
    error_message = <<-EOF
      Variable attribute 'account_license_type' has an invalid value.
      Value must be one of:
        "basic", "stakeholder", "advanced", "express", "none" or null
    EOF
  }
  validation {
    condition     = var.user_entitlement.licensing_source == null ? true : contains(["account", "auto", "msdn", "none", "profile", "trial"], var.user_entitlement.licensing_source)
    error_message = <<-EOF
      Variable attribute 'licensing_source' has an invalid value.
      Value must be one of:
        "account", "auto", "msdn", "none", "profile", "trial" or null
    EOF
  }
}

variable "azuread_groups" {
  description   = "list of Azure AD groups to process"
  type          = list(string)
  validation {
    condition     = alltrue([for group in var.azuread_groups : startswith(group, "ADO-")])
    error_message = <<-EOF
      Variable 'azuread_groups' has one ore more invalid group name values.
      As per naming convention all Azure DevOps group names must start with:
      "ADO-"
    EOF
  }
}