####################################################################################################
#   Provider configuration                                                                         # 
####################################################################################################

provider "azurerm" {
  tenant_id                  = var.tenant_id
  subscription_id            = var.subscription_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
  features {
    subscription {
      prevent_cancellation_on_destroy        = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}