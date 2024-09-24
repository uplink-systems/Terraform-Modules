####################################################################################################
#   Variables declaration (Azure RM DNS variables)                                                 #
####################################################################################################

variable "azurerm_dns" {
  description = "Azure RM DNS settings for zones and record sets"
  type        = map(object({
    name                = string
    resource_group_name = string
    tags                = map(string)
    recordset_a         = map(object({
      name                = string
      records             = list(string)
      ttl                 = optional(number, 3600)
    }))
    recordset_aaaa      = map(object({
      name                = string
      records             = list(string)
      ttl                 = optional(number, 3600)
    }))
    recordset_caa       = map(object({
      name                = string
      record              = list(string)
      ttl                 = optional(number, 3600)
    }))
    recordset_cname     = map(object({
      name                = string
      record              = string
      ttl                 = optional(number, 3600)
    }))
    recordset_mx        = map(object({
      name                = string
      record              = list(string)
      ttl                 = optional(number, 3600)
    }))
    recordset_ns        = map(object({
      name                = string
      records             = list(string)
      ttl                 = optional(number, 172800)
    }))
    recordset_srv       = map(object({
      name                = string
      record              = list(string)
      ttl                 = optional(number, 3600)
    }))
    recordset_txt       = map(object({
      name                = string
      record              = list(string)
      ttl                 = optional(number, 3600)
    }))
  }))
}

####################################################################################################
#   Resource provisioning/management via 'azurerm_dns' module                                      #
#   Azure RM DNS zone and record set resources                                                     #
####################################################################################################

module "azurerm_dns" {
  source                 = "github.com/uplink-systems/Terraform-Modules//modules/azurerm/dns"
  for_each               = var.azurerm_dns
  name                   = each.value.name
  resource_group_name    = each.value.resource_group_name
  tags                   = each.value.tags
  recordset_a            = each.value.recordset_a
  recordset_aaaa         = each.value.recordset_aaaa
  recordset_caa          = each.value.recordset_caa
  recordset_cname        = each.value.recordset_cname
  recordset_mx           = each.value.recordset_mx
  recordset_ns           = each.value.recordset_ns
  recordset_srv          = each.value.recordset_srv
  recordset_txt          = each.value.recordset_txt
}