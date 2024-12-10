####################################################################################################
#   Variables declaration (Provider variables)                                                     #
####################################################################################################

variable "ad_hostname" { 
  description    = "AD DNS domain name or AD domain controller FQDN"
  type           = string
}

variable "ad_user" { 
  description    = "AD domain administrator's username"
  type           = string
}

variable "ad_password" { 
  description    = "AD domain administrator's password"
  type           = string
}
