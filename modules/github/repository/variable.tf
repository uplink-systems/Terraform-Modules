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
    archive_on_destroy                      = optional(bool, null)
    archived                                = optional(bool, null)
    auto_init                               = optional(bool, true)
    delete_branch_on_merge                  = optional(bool, null)
    gitignore_template                      = optional(string, null)
    has_discussions                         = optional(bool, false)
    has_downloads                           = optional(bool, false)
    has_issues                              = optional(bool, false)
    has_projects                            = optional(bool, false)
    has_wiki                                = optional(bool, false)
    homepage_url                            = optional(string, null)
    ignore_vulnerability_alerts_during_read = optional(bool, null)
    is_template                             = optional(bool, false)
    license_template                        = optional(string, null)
    pages                                   = optional(any, null)
    security_and_analysis                   = optional(any, null)
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
  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.repository.name))
    error_message = <<-EOF
      Naming convention violation: 'var.repository.name' has an invalid value.
      Only the following characters are allowed for the repository's name: "0-9", "a-z", ".", "-"
    EOF
  }
  validation {
    condition     = lower(var.repository.name) == var.repository.name
    error_message = <<-EOF
      Naming convention violation: 'var.repository.name' has an invalid value.
      Only lowercase letters are allowed for the repository's name.
    EOF
  }
}

variable "collaborator" {
  description = "(Optional) Lists of collaborators separated by their permission (full/maintain/read-only/read-write/triage)"
  type        = object({
    enabled     = optional(bool, true)
    admin       = optional(list(string), [])
    maintain    = optional(list(string), [])
    pull        = optional(list(string), [])
    push        = optional(list(string), [])
    triage      = optional(list(string), [])
  })
  default     = { enabled = false }
}

variable "team" {
  description = "(Optional) Lists of team names separated by their permission (full/maintain/read-only/read-write/triage)"
  type        = object({
    enabled     = optional(bool, true)
    admin       = optional(list(string), [])
    maintain    = optional(list(string), [])
    pull        = optional(list(string), [])
    push        = optional(list(string), [])
    triage      = optional(list(string), [])
  })
  default     = { enabled = false }
}

variable "branch_default" {
  description = "(Optional) Settings for the repository's default branch."
  type        = object({
    branch      = string
  })
  default     = null
}

