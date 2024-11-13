####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "team" {
  description = "Team attributes"
  type        = object({
    project_id          = string
    name                = string
    description         = optional(string, null)
  })
}

variable "team_administrators" {
  description = "Team administrators attributes"
  type        = object({
    name            = optional(list(string), ["Project Administrators"])
    mode            = optional(string, "overwrite")
  })
  default     = {
    name            = ["Project Administrators"]
    mode            = "overwrite"
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

variable "team_members" {
  description = "Team member attributes"
  type        = object({
    name            = optional(list(string), ["Readers"])
    mode            = optional(string, "add")
  })
  default     = {
    name            = ["Readers"]
    mode            = "add"
  }
  validation {
    condition     = var.team_members.mode == null ? true : contains(["add", "overwrite"], var.team_members.mode)
    error_message = <<-EOF
      Variable attribute 'mode' has an invalid value.
      Value must be one of:
        "add", "overwrite" or null
    EOF
  }
}
