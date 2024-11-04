####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

######################### DNS Zone #################################################################

resource "azurerm_dns_zone" "zone" {
  name                = var.zone.name
  resource_group_name = var.zone.resource_group_name
  tags                = var.zone.tags
  depends_on          = [local.resource_group_name]
} 

######################### DNS Record Sets: A #######################################################

resource "azurerm_dns_a_record" "recordset" {
  for_each            = var.recordset.a
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  depends_on          = [azurerm_dns_zone.zone]
}

######################### DNS Record Sets: AAAA ####################################################

resource "azurerm_dns_aaaa_record" "recordset" {
  for_each            = var.recordset.aaaa
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  depends_on          = [azurerm_dns_zone.zone]
}

######################### DNS Record Sets: CAA #####################################################

resource "azurerm_dns_caa_record" "recordset" {
  for_each            = var.recordset.caa
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = [for record in each.value.record : record]
    content {
      flags     = split(" ", record.value)[0]
      tag       = split(" ", record.value)[1]
      value     = split(" ", record.value)[2]
    }
  }
  depends_on          = [azurerm_dns_zone.zone]
}

######################### DNS Record Sets: CNAME ###################################################

resource "azurerm_dns_cname_record" "recordset" {
  for_each            = var.recordset.cname
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record
  depends_on          = [azurerm_dns_zone.zone]
}

######################### DNS Record Sets: MX ######################################################

resource "azurerm_dns_mx_record" "recordset" {
  for_each            = var.recordset.mx
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = [for record in each.value.record : record]
    content {
      exchange    = split(" ", record.value)[0]
      preference  = split(" ", record.value)[1]
    }
  }
  depends_on          = [azurerm_dns_zone.zone]
}

######################### DNS Record Sets: NS ######################################################

resource "azurerm_dns_ns_record" "recordset" {
  for_each            = var.recordset.ns
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  depends_on          = [azurerm_dns_zone.zone]
  lifecycle {
    precondition {
      # DO NOT modify the root name server record set!
      condition     = each.value.name != "@"
      error_message = "The selected resource is the Name Server root record set. Changing root record set is not allowed for this record type."
    }
  }
}

######################### DNS Record Sets: SRV #####################################################

resource "azurerm_dns_srv_record" "recordset" {
  for_each            = var.recordset.srv
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = [for record in each.value.record : record]
    content {
      port        = split(" ", record.value)[0]
      priority    = split(" ", record.value)[1]
      target      = split(" ", record.value)[2]
      weight      = split(" ", record.value)[3]
    }
  }
  depends_on          = [azurerm_dns_zone.zone]
}

######################### DNS Record Sets: TXT #####################################################

resource "azurerm_dns_txt_record" "recordset" {
  for_each            = var.recordset.txt
  name                = each.value.name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = azurerm_dns_zone.zone.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = [for record in each.value.record : record]
    content {
        value     = record.value
      }
  }
  depends_on          = [azurerm_dns_zone.zone]
}
