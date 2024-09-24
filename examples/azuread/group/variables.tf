####################################################################################################
#   Variables declaration (Provider variables)                                                     #
####################################################################################################

variable "tenant_id" {
  type        = string
  description = "Tenant ID to manage via Terraform"
  default     = "yourTenantId"
}

variable "client_id" {
  type        = string
  description = "'Terraform' app registration's Client-ID (Application ID) to authenticate to tenant"
  default     = "yourApplicationId"
}

variable "client_secret" {
  type        = string
  description = "'Terraform' app registration's Client Secret (Secret Value) to authenticate to tenant"
  default     = "yourSecretValue"
}
