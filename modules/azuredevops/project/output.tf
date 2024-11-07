####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "project" {
  description   = "project attributes"
  value         = azuredevops_project.project
}

output "project_pipeline_settings" {
  description   = "project_pipeline_settings attributes"
  value         = azuredevops_project_pipeline_settings.project_pipeline_settings
}

output "team" {
  description   = "teams attributes"
  value         = data.azuredevops_team.team
}

output "git_repository" {
  description   = "git_repository attributes"
  value         = data.azuredevops_git_repository.git_repository
}

output "import_id_team" {
  description   = "formatted import id for automatically created team"
  value         = "${azuredevops_project.project.id}/${data.azuredevops_team.team.id}"
}

output "import_id_git_repository" {
  description   = "formatted import id for automatically created git_repository"
  value         = "${azuredevops_project.project.id}/${data.azuredevops_git_repository.repository.id}"
}
