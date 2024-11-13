#################################################################################################### 
#   terraform.tf                                                                                   # 
####################################################################################################

terraform {
  required_version = "~> 1.9.0"
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "~> 1.4"
    }
    azuread = {
      source      = "hashicorp/azuread"
      version     = "~> 3.0"
    }
  }
}
