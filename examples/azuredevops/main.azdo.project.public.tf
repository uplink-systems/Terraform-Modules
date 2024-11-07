####################################################################################################
#   main.azdo.project.public.tf                                                                    #
####################################################################################################

module "project_public" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project"
  project         = {
    name            = "Public-Project"
    visibility      = "public"
    features        = {
      boards          = "disabled"
    }
  }
}

# project's default team (auto-created with project) -> import to state -> remove 'import' block after import
import {
    id = module.project_private.import_id_team
    to = module.team_public.azuredevops_team.team
}
module "team_public" {
  source              = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/team"
  team                = {
    name                = "${module.project_public.project.name} Team"
    project_id          = module.project_public.project.id
  }
  depends_on        = [ data.azuredevops_team.team_public ]
}

# project's default repository (auto-created with project) -> import to state -> remove 'import' block after import
import {
    id = module.project_private.import_id_git_repository
    to = module.repository_public.azuredevops_git_repository.git_repository
}
module "repository_public" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/git_repository"
  git_repository  = {
    name            = "${module.project_public.project.name}"
    project_id      = module.project_public.project.id
  }
  depends_on        = [ data.azuredevops_git_repository.repository_public ]
}

module "repository_public_repository_01" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/git_repository"
  git_repository  = {
    name            = "${module.project_public.project.name}-Repository_01"
    project_id      = module.project_public.project.id
    initialization  = {
      init_type       = "Clean"
    }
  }
  depends_on        = [ module.project_public ]
}
