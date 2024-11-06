####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "project" {
  description = "Project attributes"
  type        = object({
    name                = string
    description         = optional(string, null)
    features            = optional(object({
      artifacts           = optional(string, "disabled")
      boards              = optional(string, "enabled")
      repositories        = optional(string, "enabled")
      pipelines           = optional(string, "disabled")
      testplans           = optional(string, "disabled")
    }), {})
    visibility          = optional(string, "private")
    version_control     = optional(string, "Git")
    work_item_template  = optional(string, "Agile")
  })
}

variable "project_pipeline_settings" {
  description = "Project pipeline settings attributes"
  type        = object({
    enforce_job_scope                     = optional(bool, true)
    enforce_job_scope_for_release         = optional(bool, true)
    enforce_referenced_repo_scoped_token  = optional(bool, true)
    enforce_settable_var                  = optional(bool, true)
    publish_pipeline_metadata             = optional(bool, true)
    status_badges_are_private             = optional(bool, true)
  })
  default = {
    enforce_job_scope                     = true
    enforce_job_scope_for_release         = true
    enforce_referenced_repo_scoped_token  = true
    enforce_settable_var                  = true
    publish_pipeline_metadata             = true
    status_badges_are_private             = true
  }
}