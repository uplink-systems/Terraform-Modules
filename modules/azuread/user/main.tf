####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

# generate password as plaintext string
resource "random_string" "password" {
  length                = var.is_admin == false ? 12 : 16
  special               = true
  min_lower             = 1
  min_numeric           = 1
  min_special           = 1
  min_upper             = 1
  override_special      = "!#$%&*()-_=+[]{}<>:?"
}

# create user
resource "azuread_user" "user" {
  surname                     = var.surname
  given_name                  = var.given_name
  display_name                = var.display_name == null ? local.display_name : var.display_name
  user_principal_name         = var.user_principal_name == null ? local.user_principal_name : var.user_principal_name
  account_enabled             = var.account_enabled
  password                    = random_string.password.result
  force_password_change       = var.force_password_change
  disable_password_expiration = var.disable_password_expiration
  disable_strong_password     = var.is_admin == false ? var.disable_strong_password : false
  preferred_language          = var.preferred_language
  usage_location              = var.usage_location
  mail_nickname               = var.mail_nickname == null ? local.mail_nickname : var.mail_nickname
  mail                        = var.mail == null ? local.mail : var.mail
  other_mails                 = var.other_mails
  show_in_address_list        = var.is_admin == false ? var.show_in_address_list : false
  employee_id                 = var.employee_id
  employee_type               = var.employee_type
  job_title                   = var.job_title
  company_name                = var.company_name
  division                    = var.division
  department                  = var.department
  cost_center                 = var.cost_center
  manager_id                  = var.is_admin == false ? (var.manager_id == null ? null : data.azuread_user.manager_id.0.object_id) : null
  country                     = var.country
  state                       = var.state
  postal_code                 = var.postal_code
  city                        = var.city
  street_address              = var.street_address
  office_location             = var.office_location
  business_phones             = var.business_phones
  mobile_phone                = var.mobile_phone
  fax_number                  = var.fax_number
  age_group                   = var.age_group
  consent_provided_for_minor  = var.consent_provided_for_minor
  depends_on                  = [ random_string.password ]
  lifecycle {
    ignore_changes  = [ force_password_change, password, preferred_language, usage_location ]
  }
}

# create credential output file
resource "local_file" "credential" {
  count       = var.export_enabled == true ? 1 : 0
  content     = <<-EOT
    ${azuread_user.user.user_principal_name}
    ${random_string.password.result}
  EOT
  filename    = local.export
  depends_on  = [ azuread_user.user ]
}
