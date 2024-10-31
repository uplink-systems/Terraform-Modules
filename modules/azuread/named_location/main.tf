####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuread_named_location" "named_location" {
  display_name    = var.named_location.display_name
  dynamic "country" {
    for_each        = var.named_location.country.enabled ? [1] : []
    content {
      countries_and_regions                 = var.named_location.country.countries_and_regions
      include_unknown_countries_and_regions = var.named_location.country.include_unknown_countries_and_regions
    }
  }
  dynamic "ip" {
    for_each        = var.named_location.ip.enabled ? [1] : []
    content {
      ip_ranges                             = var.named_location.ip.ip_ranges
      trusted                               = var.named_location.ip.trusted
    }
  }
}
