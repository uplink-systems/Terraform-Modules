####################################################################################################
#   terraform.tf                                                                                   # 
####################################################################################################

terraform {
  required_providers {
    ad = {
      source  = "registry.terraform.io/hashicorp/ad"
      version = "~> 0.5"
    }
  }
}
