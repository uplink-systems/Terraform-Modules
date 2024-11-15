####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "repository_policy" {
  description = "Repository Policy attributes"
  type        = object({
    project_id            = string
    repository_ids        = optional(list(string), null)
    author_email_pattern  = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
      author_email_patterns   = list(string)
    }), {
      enabled                 = false
      author_email_patterns   = ["*@example.code"]
    })
    case_enforcment       = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
      enforce_consistent_case = optional(bool, true)
    }), {
      enabled                 = false
      enforce_consistent_case = false
    })
    check_credentials     = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
    }), { enabled = false })
    file_path_pattern     = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
      file_path_patterns      = list(string)
    }), {
      enabled                 = false
      file_path_patterns      = ["example.code","/code/*.example"]
    })
    max_file_size         = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
      max_file_size           = optional(number, 10)
    }), { enabled = false })
    max_path_length       = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
      max_path_length         = optional(number, 1000)
    }), { enabled = false })
    reserved_names        = optional(object({
      enabled                 = optional(bool, true)
      blocking                = optional(bool, true)
    }), { enabled = false })
  })
}