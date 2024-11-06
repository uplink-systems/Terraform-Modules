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
