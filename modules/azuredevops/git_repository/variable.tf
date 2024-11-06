####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "git_repository" {
  description = "parameter for Git repository"
  type        = object({
    name                  = string
    project_id            = string
    default_branch        = optional(string, null) #"refs/heads/main")
    disabled              = optional(bool, false)
    initialization        = optional(object({
      init_type             = optional(string, "Clean")
      source_type           = optional(string, null)
      source_url            = optional(string, null)
      service_connection_id = optional(string, null)
    }), {})
    parent_repository_id  = optional(string, null)
  })
  validation {
    condition     = var.git_repository.initialization.init_type == null ? true : contains(["Clean", "Import", "Uninitialized"], var.git_repository.initialization.init_type)
    error_message = <<-EOF
      Variable attribute 'initialization.init_type' has an invalid value.
      Value must be one of:
        "Clean", "Import", "Uninitialized"
    EOF
  }
}