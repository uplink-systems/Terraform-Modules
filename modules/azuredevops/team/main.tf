####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

# configuring team
resource "azuredevops_team" "team" {
  name        = var.team.name
  project_id  = var.team.project_id
  description = var.team.description
}

# configuring team administrators
resource "azuredevops_team_administrators" "team_administrators" {
  project_id      = var.team.project_id
  team_id         = azuredevops_team.team.id
  mode            = var.team_administrators.mode
  administrators  = [
    data.azuredevops_group.team_administrators.descriptor
  ]
  depends_on      = [ azuredevops_team.team,data.azuredevops_group.team_administrators ]
}

# configuring team members
resource "azuredevops_team_members" "team_members" {
  project_id      = var.team.project_id
  team_id         = azuredevops_team.team.id
  mode            = var.team_members.mode
  members         = [
    data.azuredevops_group.team_members.descriptor
  ]
  depends_on      = [ azuredevops_team.team,data.azuredevops_group.team_members ]
}
