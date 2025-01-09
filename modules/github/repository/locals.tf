####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  repository      = {
    template                  = var.repository.template == null ? [] : [var.repository.template]
    visibility                = var.repository.visibility == null ? "private" : var.repository.visibility
    security_and_analysis     = {
      advanced_security               = {
        status                          = var.repository.visibility == "public" ? null : try(var.repository.security_and_analysis.advanced_security.status, null)
      }
      secret_scanning                 = {
        status                          = (var.repository.visibility == "public" ? try(var.repository.security_and_analysis.secret_scanning.status, "disabled") : (try(var.repository.security_and_analysis.advanced_security.status == "enabled", false) ? try(var.repository.security_and_analysis.secret_scanning.status, null) : null))
      }
      secret_scanning_push_protection = {
        status                          = (var.repository.visibility == "public" ? try(var.repository.security_and_analysis.secret_scanning_push_protection.status, "disabled") : (try(var.repository.security_and_analysis.advanced_security.status == "enabled", false) ? try(var.repository.security_and_analysis.secret_scanning_push_protection.status, null) : null))
      }
    }
  }
  collaborator    = {
    admin                     = [ for i in var.collaborator.admin : { username = i, permission = "admin" } ]
    maintain                  = [ for i in var.collaborator.maintain : { username = i, permission = "maintain" } ]
    pull                      = [ for i in var.collaborator.pull : { username = i, permission = "pull" } ]
    push                      = [ for i in var.collaborator.push : { username = i, permission = "push" } ]
    triage                    = [ for i in var.collaborator.triage : { username = i, permission = "triage" } ]
  }
  team            = {
    admin                     = [ for i in var.team.admin : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "admin" } ]
    maintain                  = [ for i in var.team.maintain : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "maintain" } ]
    pull                      = [ for i in var.team.pull : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "pull" } ]
    push                      = [ for i in var.team.push : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "push" } ]
    triage                    = [ for i in var.team.triage : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "triage" } ]
  }
  branch_default  = {
    branch                    = var.branch_default == null ? "main" : var.branch_default.branch
  }
}