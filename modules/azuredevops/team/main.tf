####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuredevops_team" "team" {
  name        = var.team.name
  project_id  = var.team.project_id
  description = var.team.description
}
