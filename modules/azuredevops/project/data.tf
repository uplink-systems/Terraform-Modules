####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# get client config attributes
# -> main.tf (terraform_data.initialize_default_repository/terraform_data.disable_default_repository/terraform_data.enable_default_repository)
data "azuredevops_client_config" "current" { }

# get project administrators group attributes
# -> main.tf (azuredevops_group_membership.project_administrators)
data "azuredevops_group" "project_administrators" {
  project_id      = azuredevops_project.project.id
  name            = "Project Administrators"
  depends_on      = [ azuredevops_project.project ]
}

# get project administrators new members attributes
# -> main.tf (azuredevops_group_membership.project_administrators)
data "azuredevops_users" "project_administrators" {
  count           = var.project.project_administrators.users != null ? length(var.project.project_administrators.users) : 0
  principal_name  = var.project.project_administrators.users[count.index]
  depends_on      = [ azuredevops_project.project ]
}

# project's default team (auto-created with project)
# -> output.tf (team/import_id_team)
data "azuredevops_team" "team" {
  project_id      = azuredevops_project.project.id
  name            = "${var.project.name} Team"
  depends_on      = [ azuredevops_project.project ]
}

# project's default team administrator group(s) attributes
# -> main.tf (azuredevops_team_administrators.team_administrators)
data "azuredevops_group" "team_administrators" {
  count           = length(var.team_administrators.name)
  project_id      = azuredevops_project.project.id
  name            = var.team_administrators.name[count.index]
  depends_on      = [ data.azuredevops_team.team ]
}

# project's default repository (auto-created with project)
# -> output.tf (git_repository/import_id_git_repository)
data "azuredevops_git_repository" "git_repository" {
  project_id      = azuredevops_project.project.id
  name            = var.project.name
  depends_on      = [ azuredevops_project.project ]
}
