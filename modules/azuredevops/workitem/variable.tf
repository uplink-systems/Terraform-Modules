####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "workitem" {
  description = "parameter for workitem resource"
  type        = object({
    title                 = string
    project_id            = string
    type                  = string
    area_path             = optional(string, null)
    custom_fields         = optional(any)
    iteration_path        = optional(string, null)
    state                 = optional(string, null)
    tags                  = optional(list(string), null)
  })
}
