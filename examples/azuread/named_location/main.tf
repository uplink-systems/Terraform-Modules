####################################################################################################
#   Variable declaration and Module calls:                                                         #
#   Azure AD country/geolocation based named locations                                             #
####################################################################################################

variable "azuread_named_location_country" {
  description = "Azure AD country/geolocation based named location variables"
  type        = map(object({
    display_name                            = string
    description                             = optional(string, null)
    country                                 = set(string)
    include_unknown_countries_and_regions   = optional(bool, false)
  }))
}

module "azuread_named_location_country" {
  source                                  = "./modules/azuread_named_location_country"
  for_each                                = var.azuread_named_location_country
  display_name                            = each.value.display_name
  description                             = each.value.description
  country                                 = each.value.country
  include_unknown_countries_and_regions   = each.value.include_unknown_countries_and_regions
}

####################################################################################################
#   Variable declaration and Module calls:                                                         #
#   Azure AD ip/range based named locations                                                        #
####################################################################################################

variable "azuread_named_location_ip" {
  description = "Azure AD ip/range based named location variables"
  type        = map(object({
    display_name                            = string
    description                             = optional(string, null)
    ip_ranges                               = set(string)
    trusted                                 = optional(bool, false)
  }))
}

module "azuread_named_location_ip" {
  source                                  = "./modules/azuread_named_location_ip"
  for_each                                = var.azuread_named_location_ip
  display_name                            = each.value.display_name
  description                             = each.value.description
  ip_ranges                               = each.value.ip_ranges
  trusted                                 = each.value.trusted
}