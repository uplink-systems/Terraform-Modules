####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "azuread_user" {
  description = "output all user's attributes and values"
  value       = azuread_user.user
}

output "azuread_user_credential" {
  description = "ouput the user's upn, password and credential file path/name as map"
  value       = tomap({
    username        = azuread_user.user.user_principal_name
    password        = nonsensitive(random_password.password.result)
    credential_file = length(local_sensitive_file.credential) > 0 ? local.export.filename : null
  })
}

output "azuread_user_credential_csv" {
  description = "output the user's upn and password as comma-separated values"
  value       = "${azuread_user.user.user_principal_name},${nonsensitive(random_password.password.result)}"
}
