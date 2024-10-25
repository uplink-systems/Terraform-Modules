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
  description = "(Optional) user's login name; if null: build by module from surname/given_name"
  type        = string
  default     = null
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
  description = "(Optional) choose if user' password is set to \"never expire\""
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
    condition     = var.preferred_language == null ? true : length(var.preferred_language) == 5
    error_message = "Error: Variable 'preferred_language' has an invalid value length. Value must be one of: \"2-2\"-formatted 5-character regional code or null."
  }
}
variable "usage_location" {
  description = "(Optional) user's usage location (create only (variable changes is in ignore list))"
  type        = string
  default     = null
  validation {
    condition     = var.usage_location == null ? true : length(var.usage_location) == 2
    error_message = "Error: Variable 'usage_location' has an invalid value length. Value must be one of: 2-character country ISO-code or null."
  }
  validation {
    condition     = var.usage_location == null ? true : contains(["DE","AT"], var.usage_location)
    error_message = "Error: Variable 'usage_location' has an invalid value. Value must be one of: \"DE\", \"AT\" or null."
  }
}
variable "mail_nickname" {
  description = "(Optional) user's mail nickname; if null: build by module from surname/given_name"
  type        = string
  default     = null
}
variable "mail" {
  description = "(Optional) user's primary mail address; if null: build by module from surname/given_name"
  type        = string
  default     = null
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
  description = "(Optional) user's manager id as user principal name"
  type        = string
  default     = null
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
    condition     = var.country == null ? true : length(var.country) == 2
    error_message = "Error: Variable 'country' has an invalid value length. Value must be one of: 2-character country ISO-code or null."
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
    error_message = "Error: Variable 'postal_code' has an invalid value type. Value must be one of: digits-only or null."
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
    condition     = var.age_group == null ? true : contains(["Adult", "NotAdult", "Minor"], var.age_group)
    error_message = "Error: Variable 'age_group' has an invalid value. Value must be one of: \"Adult\", \"NotAdult\", \"Minor\"  or null."
  } 
}
variable "consent_provided_for_minor" {
  description = "(Optional) wether consent was provided for user if minor"
  type        = string
  default     = null
  validation {
    condition     = var.consent_provided_for_minor == null ? true : contains(["Granted", "Denied", "NotRequired"], var.consent_provided_for_minor)
    error_message = "Error: Variable 'consent_provided_for_minor' has an invalid value. Value must be one of: \"Granted\", \"Denied\", \"NotRequired\"  or null."
  } 
}
variable "credential_export" {
  description = "(Optional) choose to export user's credentials to file or not"
  type        = bool
  default     = true
}
variable "credential_file_path" {
  description = "(Optional) physical output path for credential file exports"
  type        = string
  default     = null
}
variable "credential_file_name" {
  description = "(Optional) physical output file name for credential file exports"
  type        = string
  default     = null
}
