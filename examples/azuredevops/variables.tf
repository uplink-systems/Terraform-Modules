####################################################################################################
#   Declaration of available variables                                                             #
####################################################################################################

#####  Azure DevOps  ###############################################################################

variable "org_service_url" {
  type        = string
  description = "Azure DevOps Service URL"
}

variable "personal_access_token" {
  type        = string
  description = "Azure DevOps Personal Access Token"
}

#####  Azure AD  ###################################################################################

variable "tenant_id" {
  description = "Tenant ID to manage via Terraform"
  type        = string
}
variable "client_id" {
  description = "'Terraform' app registration's Client-ID (Application ID) to authenticate to  tenant"
  type        = string
}
variable "client_secret" {
  description = "'Terraform' app registration's Client Secret (Secret Value) to authenticate to tenant"
  type        = string
}
