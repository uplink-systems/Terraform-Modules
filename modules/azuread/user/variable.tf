####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "given_name" {
  description = "(Required) user's first name"
  type        = string
}
variable "surname" {
  description = "(Required) user's last name"
  type        = string
}
variable "display_name" {
  description = "(Optional) user's display name; if null: build by module from surname/given_name"
  type        = string
  default     = null
}
variable "user_principal_name" {
  description = "(Optional) user's RFC 822 based user principal name; if null: build by module from surname/given_name"
  type        = string
  default     = null
  validation {
    condition     = var.user_principal_name == null ? true : can(length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user_principal_name)) > 0)
    error_message = <<-EOF
      Variable 'user_principal_name' has an invalid value: ${var.user_principal_name == null ? 0 : var.user_principal_name}
      Value must be one of:
        RFC 822 based login UPN or null
    EOF
  }
}
variable "account_enabled" {
  description = "(Optional) is user's account enabled or disabled?"
  type        = bool
  default     = true
}
variable "force_password_change" {
  description = "(Optional) choose if user is forced to change his/her password (create only (variable changes is in ignore list))"
  type        = bool
  default     = true
}
variable "disable_password_expiration" {
  description = "(Optional) choose if user' password is set to 'never expire'"
  type        = bool
  default     = false
}
variable "disable_strong_password" {
  description = "(Optional) choose if user can use weak passwords"
  type        = bool
  default     = false
}
variable "is_admin" {
  description = "(Optional) helper variable to choose if the user's account is an admin account"
  type        = bool
  default     = false
}
variable "preferred_language" {
  description = "(Optional) user's preferred language (create only (variable changes is in ignore list))"
  type        = string
  default     = "en-US"
  validation {
    condition     = var.preferred_language == null ? true : can(regex("[a-z][a-z]-[A-Z][A-Z]", var.preferred_language))
    error_message = <<-EOF
      Variable 'preferred_language' has an invalid value format: ${var.preferred_language == null ? 0 : var.preferred_language}
      Value must be one of:
        regional code "2-2" in format ([a-z][a-z]-[A-Z][A-Z]) or null
    EOF
  }
}
variable "usage_location" {
  description = "(Optional) user's usage location (create only (variable changes is in ignore list))"
  type        = string
  default     = null
  validation {
    condition     = var.usage_location == null ? true : can(regex("[A-Z][A-Z]", var.usage_location))
    error_message = <<-EOF
      Variable 'usage_location' has an invalid value: ${var.usage_location == null ? 0 : var.usage_location}
      Value must be one of:
        2-character ISO 3166-1 country code or null
    EOF
  }
}
variable "mail_nickname" {
  description = "(Optional) user's mail nickname; if null: build by module from surname/given_name"
  type        = string
  default     = null
}
variable "mail" {
  description = "(Optional) user's RFC 5322 compliant primary mail address; if null: build by module from surname/given_name"
  type        = string
  default     = null
  validation {
    condition     = var.mail == null ? true : can(length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.mail)) > 0)
    error_message = <<-EOF
      Variable 'mail' has an invalid value: ${var.mail == null ? 0 : var.mail}
      Value must be one of:
        RFC 5322 compliant email address or null
    EOF
  }
}
variable "other_mails" {
  description = "(Optional) user's list of other (external) mail addresses"
  type        = list(string)
  default     = []
}
variable "show_in_address_list" {
  description = "(Optional) user's account to show in global address list or not?"
  type        = bool
  default     = true
}
variable "employee_id" {
  description = "(optional) user's employee id"
  type        = string
  default     = null
}
variable "employee_type" {
  description = "(Optional) user's employee type"
  type        = string
  default     = null
  validation {
    condition     = var.employee_type == null ? true : can(contains(["Administrator", "Employee", "Contractor"], var.employee_type))
    error_message = <<-EOF
      Variable 'employee_type' has an invalid value value: ${var.employee_type == null ? 0 : var.employee_type}
      Value must be one of:
        "Administrator", "Employee", "Contractor" or null
    EOF
  } 
}
variable "job_title" {
  description = "(Optional) user's job title"
  type        = string
  default     = null
}
variable "company_name" {
  description = "(Optional) user's company name"
  type        = string
  default     = null
}
variable "division" {
  description = "(Optional) user's division"
  type        = string
  default     = null
}
variable "department" {
  description = "(Optional) user's department"
  type        = string
  default     = null
}
variable "cost_center" {
  description = "(Optional) user's cost center"
  type        = string
  default     = null  
}
variable "manager_id" {
  description = "(Optional) user's manager id as RFC 822 based user principal name"
  type        = string
  default     = null
  validation {
    condition     = var.manager_id == null ? true : can(length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.manager_id)) > 0)
    error_message = <<-EOF
      Variable 'manager_id' has an invalid value: ${var.manager_id == null ? 0 : var.manager_id}
      Value must be one of:
        RFC 822 based login UPN or null
    EOF
  }
}
variable "sponsors" {
  description = "(Optional) list of user's sponsor(s) as user principal name(s)"
  type        = list(string)
  default     = []
}
variable "country" {
  description = "(Optional) user's location country as 2-digit iso-code"
  type        = string
  default     = null
  validation {
    condition     = var.country == null ? true : can(regex("[A-Z][A-Z]", var.country))
    error_message = <<-EOF
      Variable 'country' has an invalid value: ${var.country == null ? 0 : var.country}
      Value must be one of:
        2-character ISO 3166-1 country code or null
    EOF
  }
}
variable "state" {
  description = "(Optional) user's location state"
  type        = string
  default     = null
}
variable "postal_code" {
  description = "(Optional) user's location postal code"
  type        = string
  default     = null
  validation {
    condition     = var.postal_code == null ? true : can(tonumber(var.postal_code))
    error_message = <<-EOF
      Variable 'postal_code' has an invalid value: ${var.postal_code == null ? 0 : var.postal_code}
      Value must be one of:
        numerical data or null
    EOF
  }
}
variable "city" {
  description = "(Optional) user's location city"
  type        = string
  default     = null
}
variable "street_address" {
  description = "(Optional) user's location street address"
  type        = string
  default     = null
}
variable "office_location" {
  description = "(Optional) user's office location"
  type        = string
  default     = null
}
variable "business_phones" {
  description = "(Optional) user's list of business phone numbers"
  type        = list(string)
  default     = []
}
variable "mobile_phone" {
  description = "(Optional) user's mobile phone number"
  type        = string
  default     = null
}
variable "fax_number" {
  description = "(Optional) user's fax number"
  type        = string
  default     = null  
}
variable "age_group" {
  description = "(Optional) user's age group"
  type        = string
  default     = null
  validation {
    condition     = var.age_group == null ? true : can(contains(["Adult", "NotAdult", "Minor"], var.age_group))
    error_message = <<-EOF
      Variable 'age_group' has an invalid value value: ${var.age_group == null ? 0 : var.age_group}
      Value must be one of:
        "Adult", "NotAdult", "Minor" or null
    EOF
  } 
}
variable "consent_provided_for_minor" {
  description = "(Optional) wether consent was provided for user if minor"
  type        = string
  default     = null
  validation {
    condition     = var.consent_provided_for_minor == null ? true : can(contains(["Granted", "Denied", "NotRequired"], var.consent_provided_for_minor))
    error_message = <<-EOF
      Variable 'consent_provided_for_minor' has an invalid value: ${var.consent_provided_for_minor == null ? 0 : var.consent_provided_for_minor}
      Value must be one of:
        "Granted", "Denied", "NotRequired" or null
    EOF
  } 
}
variable "export_enabled" {
  description = "(Optional) choose to export user's credentials to file or not"
  type        = bool
  default     = true
}
variable "export_file" {
  description = "(Optional) physical output file for credential file exports"
  type        = string
  default     = null
}
variable "export_path" {
  description = "(Optional) physical output path for credential file exports"
  type        = string
  default     = null
}
