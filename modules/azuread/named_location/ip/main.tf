####################################################################################################
#   Azure AD named location of type "IP or IP-Range"                                               #
####################################################################################################

resource "azuread_named_location" "ip" {
  display_name = var.display_name
  ip {
    ip_ranges = [ var.ip_ranges ]
    trusted   = var.trusted
  }
}
