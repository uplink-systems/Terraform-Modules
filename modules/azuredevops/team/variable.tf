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
    name            = optional(string, "Project Administrators")
    mode            = optional(string, "overwrite")
  })
  default     = {
    name            = "Project Administrators"
    mode            = "overwrite"
  }
}

variable "team_members" {
  description = "Team member attributes"
  type        = object({
    name            = optional(string, "Readers")
    mode            = optional(string, "add")
  })
  default     = {
    name            = "Readers"
    mode            = "add"
  }
}
