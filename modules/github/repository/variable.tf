####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "repository" {
  description = "Settings for the repository. At least a 'name' value must be provided."
  type        = object({
    name                                    = string
    description                             = optional(string, null)
    allow_auto_merge                        = optional(bool, false)
    allow_merge_commit                      = optional(bool, true)
    allow_rebase_merge                      = optional(bool, true)
    allow_squash_merge                      = optional(bool, true)
    allow_update_branch                     = optional(bool, false)
    archive_on_destroy                      = optional(bool, true)
    archived                                = optional(bool, false)
    auto_init                               = optional(bool, true)
    delete_branch_on_merge                  = optional(bool, false)
    gitignore_template                      = optional(string, null)
    has_discussions                         = optional(bool, false)
    has_downloads                           = optional(bool, true)
    has_issues                              = optional(bool, true)
    has_projects                            = optional(bool, true)
    has_wiki                                = optional(bool, false)
    homepage_url                            = optional(string, null)
    ignore_vulnerability_alerts_during_read = optional(bool, false)
    is_template                             = optional(bool, false)
    license_template                        = optional(string, null)
    pages                                   = optional(any, null)
    template                                = optional(object({
      owner                                   = string
      repository                              = string
      include_all_branches                    = optional(bool, false)
    }), null)
    topics                                  = optional(list(string), null)
    visibility                              = optional(string, null)
    vulnerability_alerts                    = optional(bool, null)
    web_commit_signoff_required             = optional(bool, false)
  })
}

variable "branch_default" {
  description = "(Optional) Settings for the repository's default branch."
  type        = object({
    branch      = string
  })
  default     = null
}

