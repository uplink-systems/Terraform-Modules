####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "organization" {
  description = "Organization attributes required for the project's resources"
  type        = object({
    personal_access_token   = string
  })
}

variable "project" {
  description = "Project attributes"
  type        = object({
    name                        = string
    description                 = optional(string, null)
    features                    = optional(object({
      artifacts                   = optional(string, "disabled")
      boards                      = optional(string, "enabled")
      repositories                = optional(string, "enabled")
      pipelines                   = optional(string, "disabled")
      testplans                   = optional(string, "disabled")
    }), {})
    visibility                  = optional(string, "private")
    version_control             = optional(string, "Git")
    work_item_template          = optional(string, "Agile")
    project_administrators      = optional(object({
      users                       = optional(list(string), null)
      mode                        = optional(string, "overwrite")
    }), {})
    disable_default_repository  = optional(bool, false)
    enable_default_repository   = optional(bool, false)
  })
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.project.name))
    error_message = <<-EOF
      Variable attribute 'name' has an invalid value.
      Value must only contain the following characters:
        "0-9", "a-z", "A-Z" and "-"
    EOF
  }
  validation {
    condition     = var.project.features.artifacts == null ? true : contains(["enabled", "disabled"], var.project.features.artifacts)
    error_message = <<-EOF
      Variable attribute 'features.artifacts' has an invalid value.
      Value must be one of:
        "enabled", "disabled" or null
    EOF
  }
  validation {
    condition     = var.project.features.boards == null ? true : contains(["enabled", "disabled"], var.project.features.boards)
    error_message = <<-EOF
      Variable attribute 'features.boards' has an invalid value.
      Value must be one of:
        "enabled", "disabled" or null
    EOF
  }
  validation {
    condition     = var.project.features.repositories == null ? true : contains(["enabled", "disabled"], var.project.features.repositories)
    error_message = <<-EOF
      Variable attribute 'features.repositories' has an invalid value.
      Value must be one of:
        "enabled", "disabled" or null
    EOF
  }
  validation {
    condition     = var.project.features.pipelines == null ? true : contains(["enabled", "disabled"], var.project.features.pipelines)
    error_message = <<-EOF
      Variable attribute 'features.pipelines' has an invalid value.
      Value must be one of:
        "enabled", "disabled" or null
    EOF
  }
  validation {
    condition     = var.project.features.testplans == null ? true : contains(["enabled", "disabled"], var.project.features.testplans)
    error_message = <<-EOF
      Variable attribute 'features.testplans' has an invalid value.
      Value must be one of:
        "enabled", "disabled" or null
    EOF
  }
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
  validation {
    condition     = var.project.project_administrators.mode == null ? true : contains(["add", "overwrite"], var.project.project_administrators.mode)
    error_message = <<-EOF
      Variable attribute 'project_administrators.mode' has an invalid value.
      Value must be one of:
        "add", "overwrite" or null
    EOF
  }
  validation {
    condition     = (var.project.disable_default_repository && var.project.enable_default_repository ) ? false : true
    error_message = <<-EOF
      Variable attributes' values 'var.project.disable_default_repository' and 'var.project.enable_default_repository' are both set to 'true'.
      Default repository can only be disabled OR enabled but not both.
    EOF
  }
}

variable "team_administrators" {
  description = "Project's default team administrators"
  type        = object({
    name        = optional(list(string), ["Project Administrators"])
    mode        = optional(string, "overwrite")
  })
  default = {
    name        = ["Project Administrators"]
    mode        = "overwrite"
  }
  validation {
    condition     = var.team_administrators.mode == null ? true : contains(["add", "overwrite"], var.team_administrators.mode)
    error_message = <<-EOF
      Variable attribute 'mode' has an invalid value.
      Value must be one of:
        "add", "overwrite" or null
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
