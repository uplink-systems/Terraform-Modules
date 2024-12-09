####################################################################################################
#   terraform.tf                                                                                   #
####################################################################################################

terraform {
  required_providers {
    pkcs12 = {
      source  = "registry.terraform.io/chilicat/pkcs12"
      version = "~> 0.2"
    }
    local = {
      source  = "registry.terraform.io/hashicorp/local"
      version = "~> 2.0"
    }
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "registry.terraform.io/hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
