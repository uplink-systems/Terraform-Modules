####################################################################################################
#   terraform.tf                                                                                   #
####################################################################################################

terraform {
  required_providers {
    azuredevops = {
      source      = "registry.terraform.io/microsoft/azuredevops"
      version     = "~> 1.4"
    }
  }
}