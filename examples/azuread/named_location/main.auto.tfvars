####################################################################################################
#   Variable values:                                                                               #
#   Azure AD named locations                                                                       # 
####################################################################################################

azuread_named_location = {
  "Named-Location-Country-01" = {
    "named_location" = {
      display_name  = "Named-Location-Country-01"
      country = {
        countries_and_regions = [
          "KN",
          "RU",
          "BY",
        ]
        include_unknown_countries_and_regions = true
      }
    }
  }
  "Named-Location-Country-02" = {
    "named_location" = {
      display_name  = "Named-Location-Country-02"
      country = {
        countries_and_regions = [
          "DE",
          "AT",
        ]
        include_unknown_countries_and_regions = false
      }
    }
  }
  "Named-Location-IP-01" = {
    named_location = {
      display_name  = "Named-Location-IP-01"
      ip  = {
        ip_ranges = [
          "47.11.8.15/32",
          "88.77.66.0/24",
        ]
      }
    }
  }
  "Named-Location-IP-02" = {
    "named_location" = {
      display_name  = "Named-Location-IP-02"
      ip  = {
        ip_ranges = [
          "101.202.102.203/32",
        ]
        trusted = true
      }
    }
  }
}
