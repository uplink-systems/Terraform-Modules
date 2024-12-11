####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  terraform_data = {
    initialize_default_repository = {
      uri   = "${data.azuredevops_client_config.current.organization_url}/${azuredevops_project.project.id}/_apis/git/repositories/${data.azuredevops_git_repository.git_repository.id}/pushes?api-version=7.1"
    }
    disable_default_repository = {
      uri   = "${data.azuredevops_client_config.current.organization_url}/${azuredevops_project.project.id}/_apis/git/repositories/${data.azuredevops_git_repository.git_repository.id}/?api-version=7.1"
    }
    enable_default_repository = {
      uri   = "${data.azuredevops_client_config.current.organization_url}/${azuredevops_project.project.id}/_apis/git/repositories/${data.azuredevops_git_repository.git_repository.id}/?api-version=7.1"
    }
  }
}