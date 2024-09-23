####################################################################################################
#   Variable values:                                                                               #
#   Azure AD country/geolocation based named locations                                             # 
####################################################################################################
azuread_named_location_country = {
  "Named-Location-Country-01" = {
    display_name                            = "Named-Location-Country-01"
    description                             = "Description for Named-Location-Country-01"
    country                                 = [ CN, KN, RU ]
    include_unknown_countries_and_regions   = true
  }
  "Named-Location-Country-02" = {
    display_name                            = "Named-Location-Country-02"
    description                             = "Description for Named-Location-Country-02"
    country                                 = [ AT, DE ]
  }
}

####################################################################################################
#   Variable values:                                                                               #
#   Azure AD ip/range based named locations                                                        # 
####################################################################################################
azuread_named_location_ip = {
  "Named-Location-IP-01" = {
    display_name                            = "Named-Location-IP-01"
    description                             = "Description for Named-Location-IP-01"
    ip_ranges                               = [ 47.11.8.15/32, 88.77.66.0/24 ]
  }
  "Named-Location-IP-02" = {
    display_name                            = "Named-Location-IP-02"
    description                             = "Description for Named-Location-IP-02"
    ip_ranges                               = [ 101.202.102.203/32 ]
    trusted                                 = true
  }
}