#################################################################################################### 
#   Base Configuration                                                                             # 
####################################################################################################
terraform {
  required_version = "~> 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

####################################################################################################
#   Provider Setup                                                                                 # 
####################################################################################################
provider "azurerm" {
  tenant_id                  = var.tenant_id
  subscription_id            = var.subscription_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
  skip_provider_registration = true
  features {
    subscription {
      prevent_cancellation_on_destroy        = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}