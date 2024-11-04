####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "user" {
  type = object({
    given_name                  = string
    surname                     = string
    display_name                = optional(string, null)
    user_principal_name         = optional(string, null)
    account_enabled             = optional(bool, true)
    force_password_change       = optional(bool, true)
    disable_password_expiration = optional(bool, false)
    disable_strong_password     = optional(bool, false)
    is_admin                    = optional(bool, false)
    preferred_language          = optional(string, "en-US")
    usage_location              = optional(string, null)
    mail_nickname               = optional(string, null)
    mail                        = optional(string, null)
    other_mails                 = optional(list(string), [])
    show_in_address_list        = optional(bool, true)
    employee_id                 = optional(string, null)
    employee_type               = optional(string, null)
    job_title                   = optional(string, null)
    company_name                = optional(string, null)
    division                    = optional(string, null)
    department                  = optional(string, null)
    cost_center                 = optional(string, null)
    manager_id                  = optional(string, null)
    sponsors                    = optional(list(string), [])
    country                     = optional(string, null)
    state                       = optional(string, null)
    postal_code                 = optional(string, null)
    city                        = optional(string, null)
    street_address              = optional(string, null)
    office_location             = optional(string, null)
    business_phones             = optional(list(string), [])
    mobile_phone                = optional(string, null)
    fax_number                  = optional(string, null)
    parental_control            = optional(object({
      enabled                     = optional(bool, true)
      age_group                   = optional(string, null)
      consent_provided_for_minor  = optional(string, null)
    }), { enabled = false })
    export                      = optional(object({
      enabled                     = optional(bool, true)
      file                        = optional(string, null)
      path                        = optional(string, null)
    }), { enabled = true })
  })
  # Validate variable attributes
  validation {
    condition     = var.user.user_principal_name == null ? true : length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user.user_principal_name) > 0)
    error_message = <<-EOF
      Variable attribute 'user_principal_name' has an invalid value: ${var.user.user_principal_name == null ? 0 : var.user.user_principal_name}
      Value must be one of:
        RFC 822 based login UPN or null
    EOF
  }
  validation {
    condition     = var.user.mail == null ? true : length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user.mail) > 0)
    error_message = <<-EOF
      Variable attribute 'mail' has an invalid value: ${var.user.mail == null ? 0 : var.user.mail}
      Value must be one of:
        RFC 5322 compliant email address or null
    EOF
  }
  validation {
    condition     = var.user.preferred_language == null ? true : regex("[a-z][a-z]-[A-Z][A-Z]", var.user.preferred_language)
    error_message = <<-EOF
      Variable attribute 'preferred_language' has an invalid value format: ${var.user.preferred_language == null ? 0 : var.user.preferred_language}
      Value must be one of:
        regional code "2-2" in format ([a-z][a-z]-[A-Z][A-Z]) or null
    EOF
  }
  validation {
    condition     = var.user.usage_location == null ? true : regex("[A-Z][A-Z]", var.user.usage_location)
    error_message = <<-EOF
      Variable attribute 'usage_location' has an invalid value: ${var.user.usage_location == null ? 0 : var.user.usage_location}
      Value must be one of:
        2-character ISO 3166-1 country code or null
    EOF
  }
  validation {
    condition     = var.user.employee_type == null ? true : contains(["Administrator", "Employee", "Contractor"], var.user.employee_type)
    error_message = <<-EOF
      Variable attribute 'employee_type' has an invalid value value: ${var.user.employee_type == null ? 0 : var.user.employee_type}
      Value must be one of:
        "Administrator", "Employee", "Contractor" or null
    EOF
  }
  validation {
    condition     = var.user.country == null ? true : regex("[A-Z][A-Z]", var.user.country)
    error_message = <<-EOF
      Variable attribute 'country' has an invalid value: ${var.user.country == null ? 0 : var.user.country}
      Value must be one of:
        2-character ISO 3166-1 country code or null
    EOF
  }
  validation {
    condition     = var.user.postal_code == null ? true : tonumber(var.user.postal_code)
    error_message = <<-EOF
      Variable attribute 'postal_code' has an invalid value: ${var.user.postal_code == null ? 0 : var.user.postal_code}
      Value must be one of:
        numerical data or null
    EOF
  }
  validation {
    condition     = var.user.manager_id == null ? true : length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user.manager_id) > 0)
    error_message = <<-EOF
      Variable attribute 'manager_id' has an invalid value: ${var.user.manager_id == null ? 0 : var.user.manager_id}
      Value must be one of:
        RFC 822 based login UPN or null
    EOF
  }
  validation {
    condition     = var.user.parental_control.age_group == null ? true : contains(["Adult", "NotAdult", "Minor"], var.user.parental_control.age_group)
    error_message = <<-EOF
      Variable attribute 'parental_control.age_group' has an invalid value value: ${var.user.parental_control.age_group == null ? 0 : var.user.parental_control.age_group}
      Value must be one of:
        "Adult", "NotAdult", "Minor" or null
    EOF
  } 
  validation {
    condition     = var.user.parental_control.consent_provided_for_minor == null ? true : contains(["Granted", "Denied", "NotRequired"], var.user.parental_control.consent_provided_for_minor)
    error_message = <<-EOF
      Variable attribute 'parental_control.consent_provided_for_minor' has an invalid value: ${var.user.parental_control.consent_provided_for_minor == null ? 0 : var.user.parental_control.consent_provided_for_minor}
      Value must be one of:
        "Granted", "Denied", "NotRequired" or null
    EOF
  } 
}
