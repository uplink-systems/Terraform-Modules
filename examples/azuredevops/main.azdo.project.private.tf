####################################################################################################
#   main.azdo.project.private.tf                                                                   #
####################################################################################################

module "project_private" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project"
  project         = {
    name            = "Private-Project"
  }
}

# project's default team (auto-created with project) -> import to state -> remove 'import' block after import
import {
    id = "${module.project_private.project.id}/${data.azuredevops_team.team_private.id}"
    to = module.team_private.azuredevops_team.team
}
module "team_private" {
  source              = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/team"
  team                = {
    name                = "${module.project_private.project.name} Team"
    project_id          = module.project_private.project.id
  }
  depends_on        = [ data.azuredevops_team.team_private ]
}

# project's default repository (auto-created with project) -> import to state -> remove 'import' block after import
import {
    id = module.project_private.import_id_team
    to = module.repository_private.azuredevops_git_repository.git_repository
}
module "repository_private" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/git_repository"
  git_repository  = {
    name            = "${module.project_private.project.name}"
    project_id      = module.project_private.project.id
  }
  depends_on        = [ data.azuredevops_git_repository.repository_private ]
}

module "repository_private_repository_01" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/git_repository"
  git_repository  = {
    name            = "${module.project_private.project.name}-Repository_01"
    project_id      = module.project_private.project.id
    initialization  = {
      init_type       = "Clean"
    }
  }
  depends_on        = [ module.project_private ]
}
