####################################################################################################
#   Variables declaration (Azure RM DNS variables)                                                 #
####################################################################################################

variable "azurerm_dns" {
  description = "Azure RM DNS settings for zones and record sets"
  type = map(object({
    zone      = any
    recordset = optional(any, {})
  }))
}

####################################################################################################
#   Resource provisioning/management via 'azurerm_dns' module                                      #
#   Azure RM DNS zone and record set resources                                                     #
####################################################################################################

module "azurerm_dns" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azurerm/dns"
  for_each              = {for k, v in var.azurerm_dns : k => v if var.execute.azurerm_dns} #var.azurerm_dns
  zone                  = each.value.zone
  recordset             = each.value.recordset
}