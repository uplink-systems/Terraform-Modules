####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "repository_policy_author_email_pattern" {
    description   = "author_email_pattern attributes"
    value         = azuredevops_repository_policy_author_email_pattern.author_email_pattern
}

output "repository_policy_case_enforcement" {
    description   = "case_enforcement attributes"
    value         = azuredevops_repository_policy_case_enforcement.case_enforcement
}

output "repository_policy_check_credentials" {
    description   = "check_credentials attributes"
    value         = azuredevops_repository_policy_check_credentials.check_credentials
}

output "repository_policy_file_path_pattern" {
    description   = "file_path_pattern attributes"
    value         = azuredevops_repository_policy_file_path_pattern.file_path_pattern
}

output "repository_policy_max_file_size" {
    description   = "max_file_size attributes"
    value         = azuredevops_repository_policy_max_file_size.max_file_size
}

output "repository_policy_max_path_length" {
    description   = "max_path_length attributes"
    value         = azuredevops_repository_policy_max_path_length.max_path_length
}

output "repository_policy_reserved_names" {
    description   = "reserved_names attributes"
    value         = azuredevops_repository_policy_reserved_names.reserved_names
}