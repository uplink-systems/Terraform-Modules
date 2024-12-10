####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

# generate password
resource "random_password" "password" {
  length                = var.user.is_admin == false ? 12 : 16
  special               = true
  min_lower             = 1
  min_numeric           = 1
  min_special           = 1
  min_upper             = 1
  override_special      = "!#$%&*()-_=+[]{}<>:?"
}

# create user
resource "azuread_user" "user" {
  surname                     = var.user.surname
  given_name                  = var.user.given_name
  display_name                = var.user.display_name == null ? local.display_name : var.user.display_name
  user_principal_name         = var.user.user_principal_name == null ? local.user_principal_name : var.user.user_principal_name
  account_enabled             = var.user.account_enabled
  password                    = random_password.password.result
  force_password_change       = var.user.force_password_change
  disable_password_expiration = var.user.disable_password_expiration
  disable_strong_password     = var.user.is_admin == false ? var.user.disable_strong_password : false
  preferred_language          = var.user.preferred_language
  usage_location              = var.user.usage_location
  mail_nickname               = var.user.mail_nickname == null ? local.mail_nickname : var.user.mail_nickname
  mail                        = var.user.mail == null ? local.mail : var.user.mail
  other_mails                 = var.user.other_mails
  show_in_address_list        = var.user.is_admin == false ? var.user.show_in_address_list : false
  employee_id                 = var.user.employee_id
  employee_type               = var.user.employee_type
  job_title                   = var.user.job_title
  company_name                = var.user.company_name
  division                    = var.user.division
  department                  = var.user.department
  cost_center                 = var.user.cost_center
  manager_id                  = var.user.is_admin == false ? (var.user.manager_id == null ? null : data.azuread_user.manager_id.0.object_id) : null
  country                     = var.user.country
  state                       = var.user.state
  postal_code                 = var.user.postal_code
  city                        = var.user.city
  street_address              = var.user.street_address
  office_location             = var.user.office_location
  business_phones             = var.user.business_phones
  mobile_phone                = var.user.mobile_phone
  fax_number                  = var.user.fax_number
  age_group                   = var.user.parental_control.age_group
  consent_provided_for_minor  = var.user.parental_control.consent_provided_for_minor
  depends_on                  = [ random_password.password ]
  lifecycle {
    ignore_changes  = [ force_password_change, password, preferred_language, usage_location ]
  }
}

# create credential output file
resource "local_sensitive_file" "credential" {
  count       = var.user.export.enabled == true ? 1 : 0
  content     = <<-EOT
    ${azuread_user.user.user_principal_name}
    ${nonsensitive(random_password.password.result)}
  EOT
  filename    = local.export
  depends_on  = [ azuread_user.user ]
}
