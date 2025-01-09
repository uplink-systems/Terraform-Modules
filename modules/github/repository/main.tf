####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "github_repository" "repository" {
  name                                    = var.repository.name
  description                             = var.repository.description
  allow_auto_merge                        = var.repository.allow_auto_merge
  allow_merge_commit                      = var.repository.allow_merge_commit
  allow_rebase_merge                      = var.repository.allow_rebase_merge
  allow_squash_merge                      = var.repository.allow_squash_merge
  allow_update_branch                     = var.repository.allow_update_branch
  archive_on_destroy                      = var.repository.archive_on_destroy
  archived                                = var.repository.archived
  auto_init                               = var.repository.auto_init
  delete_branch_on_merge                  = var.repository.delete_branch_on_merge
  gitignore_template                      = var.repository.gitignore_template
  has_discussions                         = var.repository.has_discussions
  has_downloads                           = var.repository.has_downloads
  has_issues                              = var.repository.has_issues
  has_projects                            = var.repository.has_projects
  has_wiki                                = var.repository.has_wiki
  homepage_url                            = var.repository.homepage_url
  ignore_vulnerability_alerts_during_read = var.repository.ignore_vulnerability_alerts_during_read
  is_template                             = var.repository.is_template
  license_template                        = var.repository.license_template
  topics                                  = var.repository.topics
  visibility                              = local.repository.visbility
  vulnerability_alerts                    = var.repository.vulnerability_alerts
  web_commit_signoff_required             = var.repository.web_commit_signoff_required
  dynamic "security_and_analysis" {
    for_each = local.repository.visibility == "public" ? [true] : []
    content {
      dynamic "advanced_security" {
        for_each = local.repository.security_and_analysis.advanced_security.status != null ? [true] : []
        content {
          status                                  = local.repository.security_and_analysis.advanced_security.status        
        }
      }
      dynamic "secret_scanning" {
        for_each = local.repository.security_and_analysis.secret_scanning.status != null ? [true] : []
        content {
          status                                  = local.repository.security_and_analysis.secret_scanning.status        
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each = local.repository.security_and_analysis.secret_scanning_push_protection.status != null ? [true] : []
        content {
          status                                  = local.repository.security_and_analysis.secret_scanning_push_protection.status        
        }
      }
    }
  }
  dynamic "template" {
    for_each                                = local.repository.template
    content {
      owner                                   = template.value.owner
      repository                              = template.value.repository
      include_all_branches                    = template.value.include_all_branches
    }
  }
  lifecycle {
    ignore_changes = [ auto_init, license_template, gitignore_template, template ]
  }
}

resource "github_repository_collaborator" "collaborator" {
  for_each                                = { for i in concat(local.collaborator.admin,local.collaborator.maintain,local.collaborator.pull,local.collaborator.push,local.collaborator.triage) : i.username => i }
  repository                              = github_repository.repository.name
  username                                = each.value.username
  permission                              = each.value.permission
  depends_on                              = [ github_repository.repository ]
}

resource "github_team_repository" "team" {
  for_each                                = { for i in concat(local.team.admin,local.team.maintain,local.team.pull,local.team.push,local.team.triage) : i.slug => i }
  repository                              = github_repository.repository.name
  team_id                                 = each.value.slug
  permission                              = each.value.permission
  depends_on                              = [ github_repository.repository ]
}

resource "github_branch_default" "branch_default" {
  repository                              = github_repository.repository.name
  branch                                  = local.branch_default.branch
  depends_on                              = [ github_repository.repository ]
}