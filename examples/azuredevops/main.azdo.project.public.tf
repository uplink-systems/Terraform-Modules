####################################################################################################
#   main.azdo.project.public.tf                                                                    #
####################################################################################################

module "project_public" {
  source              = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project"
  project             = {
    name                    = "Public-Project"
    visibility              = "public"
    features                = {
      boards                    = "disabled"
    }
    project_administrators  = {
      users                     = [
        "admin.azdo@tenantname.onmicrosoft.com",
      ]
    }
  }
}

module "team_public_team_01" {
  source              = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/team"
  team                = {
    name                = "${module.project_public.project.name} Team 01"
    project_id          = module.project_public.project.id
  }
  depends_on          = [ module.project_public ]
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

module "workitem_public_workitem_01" {
  source          = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/workitem"
  workitem = {
    title                 = "${module.project_public.project.name} Workitem 01"
    project_id            = module.project_public.project.id
    type                  = "User Story"
  }
}

module "repository_policy_private_repository_policy_01" {
  source            = "github.com/uplink-systems/Terraform-Modules//modules/azuredevops/project_repository_policy"
  repository_policy = {
    project_id            = module.project_public.project.id
    repository_ids        = ["repository_public_repository_01"]
    author_email_pattern  = {
      author_email_patterns = ["project.admin@example.com","code.contributor@example.com"]
    }
    max_path_length       = {
      max_path_length       = 256
    }
  }
}

