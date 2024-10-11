####################################################################################################
#   Variable declaration and Module calls:                                                         #
#   Azure AD named locations                                                                       #
####################################################################################################

variable "azuread_named_location" {
  description = "Variable definition 'azuread_named_location'"
  type        = map(object({
    display_name     = string
    country          = optional(object({
      countries_and_regions                 = set(string)
      include_unknown_countries_and_regions = optional(bool, false)
    }), null)
    ip               = optional(object({
      ip_ranges = set(string)
      trusted   = optional(bool, false)
    }), null)
  }))
}
module "azuread_named_location" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azuread/named_location"
  for_each              = var.azuread_named_location
  display_name          = each.value.display_name
  country               = each.value.country
  ip                    = each.value.ip
}
