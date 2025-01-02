####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  repository      = {
    template        = var.repository.template == null ? [] : [var.repository.template]
  }
  branch_default  = {
    branch          = var.branch_default == null ? "main" : var.branch_default.branch
  }
}