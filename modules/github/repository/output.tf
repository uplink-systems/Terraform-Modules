####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "github_repository" {
  description = "output the github_repository attributes"
  value       = github_repository.repository
  depends_on  = [ github_repository.repository ]
}

output "github_branch_default" {
  description = "output the github_branch_default attributes"
  value       = github_branch_default.branch_default
  depends_on  = [ github_branch_default.branch_default ]
}