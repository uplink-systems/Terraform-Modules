####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "role_definition" {
  description = <<-EOF
    'var.role_definition' is the main variable for azurerm_role_definition resource settings
  EOF
  type        = object({
    name                = string
    description         = optional(string, null)
    scope               = optional(string, null)
    assignable_scopes   = optional(list(string), [])
    permissions         = optional(object({
      enabled             = optional(bool, true)
      actions             = optional(list(string), [])
      data_actions        = optional(list(string), [])
      not_actions         = optional(list(string), [])
      not_data_actions    = optional(list(string), [])
    }), {enabled = false})
  })
}