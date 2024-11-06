#################################################################################################### 
#   terraform.tf                                                                                   # 
####################################################################################################

terraform {
  required_version = "~> 1.9.0"                # any non-beta version greater than or equal to 1.7.0 and less than 1.8.0
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "~> 1.0"                      # any non-beta version greater than or equal to 1.0.0 and less than 2.0.0
    }
  }
}
