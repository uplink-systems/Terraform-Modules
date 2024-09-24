####################################################################################################
#   Variable values:                                                                               #
#   Azure RM DNS zone and record set resources                                                     # 
####################################################################################################

azurerm_dns = {
  "example.com" = {
    name                   = "example.com"
    resource_group_name    = "rg-example"
    tags                   = { "Environment"="Production","Scope"="Public" }
    recordset_a     = {
      "@"                      = { name = "@", records = ["18.128.74.45"], ttl = "3600" },
      "www"                    = { name = "www", records = ["18.128.74.45"], ttl = "3600" },
    }
    recordset_aaaa  = {
      "@"                      = { name = "@", records = ["1b92:3000:2f:272a::11:267"], ttl = "3600" },
      "www"                    = { name = "www", records = ["1b92:3000:2f:272a::11:267"], ttl = "3600" },
    }
    recordset_caa   = {
      "@"                      = { name = "@", record = ["0 iodef mailto:certadmin@example.com","0 issue letsencrypt.org","0 issuewild ;"], ttl = "3600" },
    }
    recordset_cname = {
      "autodiscover"           = { name = "autodiscover", record = "autodiscover.outlook.com", ttl = "3600" },
      "selector1._domainkey"   = { name = "selector1._domainkey", record = "selector1-example-com._domainkey.exampletenant.onmicrosoft.com", ttl = "3600" },
      "selector2._domainkey"   = { name = "selector2._domainkey", record = "selector2-example-com._domainkey.exampletenant.onmicrosoft.com", ttl = "3600" },
    }
    recordset_mx    = {
      "@"                      = {name = "@", record = ["example-com.mail.protection.outlook.com 10"], ttl = "3600" },
    }
    recordset_ns    = {
    }
    recordset_srv   = {
      "_sipfederationtls._tcp" = { name = "_sipfederationtls._tcp", record = ["5061 100 sipfed.online.lync.com 1"], ttl = "3600" },
      "_sip._tls"              = { name = "_sip._tls", record = ["443 100 sipdir.online.lync.com 1"], ttl = "3600" },
    }
    recordset_txt   = {
      "@"                      = { name = "@", record = ["MS=ms12345678","v=spf1 include:spf.protection.outlook.com -all"], ttl = "3600"} ,
    }
  }
  "example.net" = {
    name                   = "example.net"
    resource_group_name    = "rg-example"
    tags                   = { "Environment"="Production","Scope"="Public" }
    recordset_a     = {
      "@"                      = { name = "@", records = ["18.128.74.45"], ttl = "3600" },
      "www"                    = { name = "www", records = ["18.128.74.45"], ttl = "3600" },
    }
    recordset_aaaa  = {
      "@"                      = { name = "@", records = ["1b92:3000:2f:272a::11:267"], ttl = "3600" },
      "www"                    = { name = "www", records = ["1b92:3000:2f:272a::11:267"], ttl = "3600" },
    }
    recordset_caa   = {
      "@"                      = { name = "@", record = ["0 iodef mailto:certadmin@example.net","0 issue letsencrypt.org","0 issuewild ;"], ttl = "3600" },
    }
    recordset_cname = {
      "autodiscover"           = { name = "autodiscover", record = "autodiscover.outlook.com", ttl = "3600" },
      "selector1._domainkey"   = { name = "selector1._domainkey", record = "selector1-example-net._domainkey.exampletenant.onmicrosoft.com", ttl = "3600" },
      "selector2._domainkey"   = { name = "selector2._domainkey", record = "selector2-example-net._domainkey.exampletenant.onmicrosoft.com", ttl = "3600" },
    }
    recordset_mx    = {
      "@"                      = {name = "@", record = ["example-net.mail.protection.outlook.com 0"], ttl = "3600" },
    }
    recordset_ns    = {
      "childzone"              = { name = "childzone", records = ["dns.example.com.","dns.example.net.","dns.example.org.","dns.example.info."], ttl = "172800" },
    }
    recordset_srv   = {
      "_sipfederationtls._tcp" = { name = "_sipfederationtls._tcp", record = ["5061 100 sipfed.online.lync.com 1"], ttl = "3600" },
      "_sip._tls"              = { name = "_sip._tls", record = ["443 100 sipdir.online.lync.com 1"], ttl = "3600" },
    }
    recordset_txt   = {
      "@"                      = { name = "@", record = ["MS=ms98765432","v=spf1 include:spf.protection.outlook.com -all"], ttl = "3600"} ,
    }
  }
}