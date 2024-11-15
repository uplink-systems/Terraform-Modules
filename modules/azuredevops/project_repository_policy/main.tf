####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuredevops_repository_policy_author_email_pattern" "author_email_pattern" {
  project_id            = var.repository_policy.project_id
  repository_ids        = var.repository_policy.repository_ids
  enabled               = var.repository_policy.author_email_pattern.enabled
  blocking              = var.repository_policy.author_email_pattern.blocking
  author_email_patterns = var.repository_policy.author_email_pattern.author_email_patterns
}

resource "azuredevops_repository_policy_case_enforcement" "case_enforcement" {
  project_id              = var.repository_policy.project_id
  repository_ids          = var.repository_policy.repository_ids
  enabled                 = var.repository_policy.case_enforcment.enabled
  blocking                = var.repository_policy.case_enforcment.blocking
  enforce_consistent_case = var.repository_policy.case_enforcment.enforce_consistent_case
}

resource "azuredevops_repository_policy_file_path_pattern" "file_path_pattern" {
  project_id              = var.repository_policy.project_id
  repository_ids          = var.repository_policy.repository_ids
  enabled                 = var.repository_policy.file_path_pattern.enabled
  blocking                = var.repository_policy.file_path_pattern.blocking
  filepath_patterns       = var.repository_policy.file_path_pattern.file_path_patterns
}

resource "azuredevops_repository_policy_max_file_size" "max_file_size" {
  project_id              = var.repository_policy.project_id
  repository_ids          = var.repository_policy.repository_ids
  enabled                 = var.repository_policy.max_file_size.enabled
  blocking                = var.repository_policy.max_file_size.blocking
  max_file_size           = var.repository_policy.max_file_size.max_file_size
}

resource "azuredevops_repository_policy_max_path_length" "max_path_length" {
  project_id              = var.repository_policy.project_id
  repository_ids          = var.repository_policy.repository_ids
  enabled                 = var.repository_policy.max_path_length.enabled
  blocking                = var.repository_policy.max_path_length.blocking
  max_path_length         = var.repository_policy.max_path_length.max_path_length
}

resource "azuredevops_repository_policy_reserved_names" "reserved_names" {
  project_id              = var.repository_policy.project_id
  repository_ids          = var.repository_policy.repository_ids
  enabled                 = var.repository_policy.reserved_names.enabled
  blocking                = var.repository_policy.reserved_names.blocking
}

