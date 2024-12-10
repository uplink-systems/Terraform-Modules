####################################################################################################
#   local.tf                                                                                       #
####################################################################################################

locals {
  surname               = lower(replace(replace(replace(replace(replace(var.user.surname, " ", "."), "ö", "oe"), "ä", "ae"), "ü", "ue"), "ß", "ss"))
  given_name            = lower(replace(replace(replace(replace(replace(var.user.given_name, " ", "."), "ö", "oe"), "ä", "ae"), "ü", "ue"), "ß", "ss"))
  domain_name           = var.user.is_admin == false ? data.azuread_domains.default.domains.0.domain_name : data.azuread_domains.initial.domains.0.domain_name
  display_name          = var.user.is_admin == false ? format("%s, %s", var.user.surname, var.user.given_name) : format("%s, %s - Administrator", var.user.surname, var.user.given_name)
  user_principal_name   = var.user.is_admin == false ? format("%s.%s@%s", local.given_name, local.surname, local.domain_name) : format("admin.%s.%s@%s", local.given_name, local.surname, local.domain_name)
  mail                  = var.user.is_admin == false ? format("%s.%s@%s", local.given_name, local.surname, local.domain_name) : null
  mail_nickname         = var.user.is_admin == false ? format("%s.%s", local.given_name, local.surname) : null
  export                = {
    filename              = (
      var.user.export.path != null && var.user.export.file != null ? "${var.user.export.path}/${var.user.export.file}" : (
        var.user.export.path == null && var.user.export.file != null ? "${path.root}/files/export/azuread/user/${var.user.export.file}" : (
          var.user.export.path != null && var.user.export.file == null ? "${var.user.export.path}/${local.surname}_${local.given_name}.txt" : (
            "${path.root}/files/export/azuread/user/${local.surname}_${local.given_name}.txt"
          )
        )
      )
    )
  }
}
