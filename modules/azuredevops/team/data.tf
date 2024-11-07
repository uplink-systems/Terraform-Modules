####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# named administrator group
data "azuredevops_group" "team_administrators" {
  project_id      = var.team.project_id
  name            = var.team_administrators.name
  depends_on      = [ azuredevops_team.team ]
}

# named member group
data "azuredevops_group" "team_members" {
  project_id      = var.team.project_id
  name            = var.team_members.name
  depends_on      = [ azuredevops_team.team ]
}
