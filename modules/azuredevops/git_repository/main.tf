####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuredevops_git_repository" "git_repository" {
  name            = var.git_repository.name
  project_id      = var.git_repository.project_id
  default_branch  = var.git_repository.default_branch
  disabled        = var.git_repository.disabled
  initialization {
    init_type             = var.git_repository.initialization.init_type
    source_type           = var.git_repository.initialization.source_type
    source_url            = var.git_repository.initialization.source_url
    service_connection_id = var.git_repository.initialization.service_connection_id
  }
  lifecycle {
    ignore_changes = [ initialization ]
  }
}
