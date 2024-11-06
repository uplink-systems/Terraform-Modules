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

# project's default team (auto-created with project) -> read and import to team resource after project creation
data "azuredevops_team" "team_public" {
  project_id = module.project_public.project.id
  name       = "${module.project_public.project.name} Team"
  depends_on = [ module.project_public ]
}
import {
    id = "${module.project_public.project.id}/${data.azuredevops_team.team_public.id}"
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

# project's default repository (auto-created with project) -> read and import to git_repository resource after project creation
data "azuredevops_git_repository" "repository_public" {
  project_id = module.project_public.project.id
  name       = "${module.project_public.project.name}"
  depends_on = [ module.project_public ]
}
import {
    id = "${module.project_public.project.id}/${data.azuredevops_git_repository.repository_public.id}"
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
