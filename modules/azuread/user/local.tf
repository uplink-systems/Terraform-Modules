####################################################################################################
#   local.tf                                                                                       #
####################################################################################################

locals {
  surname               = lower(replace(replace(replace(replace(replace(var.surname, " ", "."), "ö", "oe"), "ä", "ae"), "ü", "ue"), "ß", "ss"))
  given_name            = lower(replace(replace(replace(replace(replace(var.given_name, " ", "."), "ö", "oe"), "ä", "ae"), "ü", "ue"), "ß", "ss"))
  domain_name           = var.is_admin == false ? data.azuread_domains.default.domains.0.domain_name : data.azuread_domains.initial.domains.0.domain_name
  display_name          = var.is_admin == false ? format("%s, %s", var.surname, var.given_name) : format("%s, %s - Administrator", var.surname, var.given_name)
  user_principal_name   = var.is_admin == false ? format("%s.%s@%s", local.given_name, local.surname, local.domain_name) : format("admin.%s.%s@%s", local.given_name, local.surname, local.domain_name)
  mail                  = var.is_admin == false ? format("%s.%s@%s", local.given_name, local.surname, local.domain_name) : null
  mail_nickname         = var.is_admin == false ? format("%s.%s", local.given_name, local.surname) : null
  credential_file_path  = var.credential_file_path == null ? "${path.root}/files/export/azuread/user" : var.credential_file_path
  credential_file_name  = var.credential_file_name == null ? "${local.surname}_${local.given_name}.txt" : var.credential_file_name
}
