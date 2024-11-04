####################################################################################################
#   main.tf: value definition via variable (multiple module calls possible via for_each loop)      #
####################################################################################################

variable "azuread_named_location" {
  description = "Variable declaration for 'azuread_named_location' module"
  default = {
    "Named-Location-Country-01" = {
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
    "Named-Location-Country-02" = {
      display_name  = "Named-Location-Country-02"
      country = {
        countries_and_regions = [
          "DE",
          "AT",
        ]
        include_unknown_countries_and_regions = false
      }
    }
    "Named-Location-IP-01" = {
      display_name  = "Named-Location-IP-01"
      ip  = {
        ip_ranges = [
          "47.11.8.15/32",
          "88.77.66.0/24",
        ]
      }
    }
    "Named-Location-IP-02" = {
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
module "azuread_named_location" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azuread/named_location"
  for_each              = var.azuread_named_location
  named_location        = each.value
}


####################################################################################################
#   main.tf: direct value definition (single module call only)                                     #
####################################################################################################

module "azuread_named_location_01" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azuread/named_location"
  named_location        = {
    display_name  = "Named-Location-01"
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

module "azuread_named_location_02" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azuread/named_location"
  named_location        = {
    display_name  = "Named-Location-02"
    ip  = {
      ip_ranges = [
        "47.11.8.15/32",
        "88.77.66.0/24",
      ]
    }
  }
}