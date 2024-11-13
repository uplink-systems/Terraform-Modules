####################################################################################################
#   data.tf                                                                                        #
####################################################################################################

# named administrator group
data "azuredevops_group" "team_administrators" {
  count           = length(var.team_administrators.name)
  project_id      = var.team.project_id
  name            = var.team_administrators.name[count.index]
  depends_on      = [ azuredevops_team.team ]
}

# named member group
data "azuredevops_group" "team_members" {
  count           = length(var.team_members.name)
  project_id      = var.team.project_id
  name            = var.team_members.name[count.index]
  depends_on      = [ azuredevops_team.team ]
}
