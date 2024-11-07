####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "git_repository" {
  description   = "git_repository attributes"
  value         = azuredevops_git_repository.git_repository
}