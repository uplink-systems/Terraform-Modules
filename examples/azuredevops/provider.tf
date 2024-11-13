
####################################################################################################
#   provider.tf                                                                                    # 
####################################################################################################

provider "azuredevops" {
  org_service_url       = var.org_service_url
  personal_access_token = var.personal_access_token
}

provider "azuread" {
  tenant_id             = var.tenant_id
  client_id             = var.client_id
  client_secret         = var.client_secret
}