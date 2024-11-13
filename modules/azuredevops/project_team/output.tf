####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "team" {
  description   = "team attributes"
  value         = azuredevops_team.team
}

output "team_administrators" {
  description   = "team_administrators attributes"
  value         = azuredevops_team_administrators.team_administrators
}

output "team_members" {
  description   = "team_members attributes"
  value         = azuredevops_team_members.team_members
}