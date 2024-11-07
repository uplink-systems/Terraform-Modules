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
  validation {
    condition     = var.project.visibility == null ? true : contains(["private", "public"], var.project.visibility)
    error_message = <<-EOF
      Variable attribute 'visibility' has an invalid value.
      Value must be one of:
        "private", "public" or null
    EOF
  }
  validation {
    condition     = var.project.version_control == null ? true : contains(["Git", "Tfvc"], var.project.version_control)
    error_message = <<-EOF
      Variable attribute 'version_control' has an invalid value.
      Value must be one of:
        "Git", "Tfvc" or null
    EOF
  }
  validation {
    condition     = var.project.work_item_template == null ? true : contains(["Agile", "Basic", "CMMI", "Scrum"], var.project.work_item_template)
    error_message = <<-EOF
      Variable attribute 'work_item_template' has an invalid value.
      Value must be one of:
        "Agile", "Basic", "CMMI", "Scrum" or null
    EOF
  }
}

variable "project_pipeline_settings" {
  description = "Project pipeline settings attributes"
  type        = object({
    enforce_job_scope                     = optional(bool, true)    # Limit job authorization scope to current project for non-release pipelines
    enforce_job_scope_for_release         = optional(bool, true)    # Limit job authorization scope to current project for release pipelines
    enforce_referenced_repo_scoped_token  = optional(bool, true)    # Protect access to repositories in YAML pipelines
    enforce_settable_var                  = optional(bool, true)    # Limit variables that can be set at queue time
    publish_pipeline_metadata             = optional(bool, false)   # Publish metadata from pipelines
    status_badges_are_private             = optional(bool, true)    # Disable anonymous access to badges
  })
  default = {
    enforce_job_scope                     = true
    enforce_job_scope_for_release         = true
    enforce_referenced_repo_scoped_token  = true
    enforce_settable_var                  = true
    publish_pipeline_metadata             = false
    status_badges_are_private             = true
  }
}
