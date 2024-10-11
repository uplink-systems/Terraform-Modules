####################################################################################################
#   Azure AD named location                                                                        #
####################################################################################################

resource "azuread_named_location" "named_location" {
  display_name          = var.display_name
  dynamic "country" {
    for_each  = var.country != null ? [var.country] : []
    content {
      countries_and_regions                   = var.country.countries_and_regions
      include_unknown_countries_and_regions   = var.country.include_unknown_countries_and_regions
    }
  }
  dynamic "ip" {
    for_each  = var.ip != null ? [var.ip] : []
    content {
      ip_ranges   = var.ip.ip_ranges
      trusted     = var.ip.trusted
    }
  }
}
