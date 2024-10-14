####################################################################################################
#   Azure RM: Custom Role Definitions                                                              # 
####################################################################################################

resource "azurerm_role_definition" "role_definition" {
  name              = var.name
  scope             = var.scope
  assignable_scopes = var.assignable_scopes
  description       = var.description
  permissions {
    actions           = var.permissions.actions
    data_actions      = var.permissions.data_actions
    not_actions       = var.permissions.not_actions
    not_data_actions  = var.permissions.not_data_actions
  }
}
