####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# project's default team (auto-created with project) -> get data for output
data "azuredevops_team" "team" {
  project_id = "${azuredevops_project.project.project_id}"
  name       = "${var.project.name} Team"
  depends_on = [ azuredevops_project.project ]
}

# project's default repository (auto-created with project) -> get data for output
data "azuredevops_git_repository" "git_repository" {
  project_id = "${azuredevops_project.project.project_id}"
  name       = "${var.project.name}"
  depends_on = [ azuredevops_project.project ]
}