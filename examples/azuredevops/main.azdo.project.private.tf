####################################################################################################
#   main.azdo.project.private.tf                                                                   #
####################################################################################################

module "project_private" {
  source              = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project"
  project             = {
    name                    = "Private-Project"
    project_administrators  = {
      users                   = [
        "admin.azdo@tenantname.onmicrosoft.com",
      ]
    }
  }
}

module "team_private_team_01" {
  source              = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project_team"
  team                = {
    name                = "${module.project_private.project.name} Team 01"
    project_id          = module.project_private.project.id
  }
  depends_on          = [ module.project_private ]
}

module "repository_private_repository_01" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project_git_repository"
  git_repository  = {
    name            = "${module.project_private.project.name}-Repository_01"
    project_id      = module.project_private.project.id
    initialization  = {
      init_type       = "Clean"
    }
  }
  depends_on        = [ module.project_private ]
}

module "workitem_private_workitem_01" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project_workitem"
  workitem        = {
    title                 = "${module.project_private.project.name} Workitem 01"
    project_id            = module.project_private.project.id
    type                  = "Issue"
    state                 = "New"
  }
  depends_on        = [ module.project_private ]
}

module "repository_policy_private_project_repository_policy" {
  source            = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project_repository_policy"
  repository_policy = {
    project_id            = module.project_private.project.id
    author_email_pattern  = {
      author_email_patterns = ["*@example.com"]
    }
    max_file_size         = {
      max_file_size         = 100
    }
  }
  depends_on        = [ module.project_private ]
}