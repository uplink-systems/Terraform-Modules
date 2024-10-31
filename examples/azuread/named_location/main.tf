####################################################################################################
#   Variable declaration and Module calls:                                                         #
#   Azure AD named locations                                                                       #
####################################################################################################

variable "azuread_named_location" {
  description = "Variable declaration for 'azuread_named_location' module"
}

module "azuread_named_location" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azuread/named_location"
  for_each              = var.azuread_named_location
  named_location        = each.value.named_location
}
