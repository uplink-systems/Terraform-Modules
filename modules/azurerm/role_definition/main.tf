####################################################################################################
#   main.tf                                                                                        # 
####################################################################################################

resource "azurerm_role_definition" "role_definition" {
  name              = var.role_definition.name
  scope             = var.role_definition.scope
  assignable_scopes = var.role_definition.assignable_scopes == [] ? var.role_definition.assignable_scopes : [var.role_definition.scope]
  description       = var.role_definition.description
  dynamic "permissions" {
    for_each            = var.role_definition.permissions.enabled ? [1] : []
    content {
      actions             = var.role_definition.permissions.actions
      data_actions        = var.role_definition.permissions.data_actions
      not_actions         = var.role_definition.permissions.not_actions
      not_data_actions    = var.role_definition.permissions.not_data_actions
    }
  }
}
