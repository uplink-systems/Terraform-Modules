####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  repository      = {
    template                  = var.repository.template == null ? [] : [var.repository.template]
    visbility                 = var.repository.visibility == null ? "private" : var.repository.visibility
    security_and_analysis     = {
      advanced_security               = {
        status                          = var.repository.visibility == "public" ? "enabled" : try(var.repository.security_and_analysis.secret_scanning.status, null)
      }
      secret_scanning                 = {
        status                          = var.repository.visibility == "public" ? try(var.repository.security_and_analysis.secret_scanning.status, null) : null
      }
      secret_scanning_push_protection = {
        status                          = var.repository.visibility == "public" ? try(var.repository.security_and_analysis.secret_scanning_push_protection.status, null) : null
      }
    }
  }
  branch_default  = {
    branch                    = var.branch_default == null ? "main" : var.branch_default.branch
  }
}