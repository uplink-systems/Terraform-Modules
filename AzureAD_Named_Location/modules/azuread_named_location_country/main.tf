####################################################################################################
#   Azure AD named location of type "Country or Region"                                            #
####################################################################################################

resource "azuread_named_location" "country" {
  display_name          = var.display_name
  country {
    countries_and_regions                 = [ var.countries_and_regions ]
    include_unknown_countries_and_regions = var.include_unknown_countries_and_regions
  }
}
