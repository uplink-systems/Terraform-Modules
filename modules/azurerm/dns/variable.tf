####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "zone" {
  description = <<-EOF
    'var.zone' is the main variable for azurerm_dns zone resource attributes
  EOF
  type = object({
    name                = string
    resource_group_name = string
    tags                = optional(map(string))
  })
}

variable "recordset" {
  description = <<-EOF
    'var.recordset' is the main variable for azurerm_dns recordset resource attributes and 
    can contain all types of recordsets that can be managed via Terraform.
  EOF
  type        = object({
    a           = optional(map(object({
      name        = string
      records     = list(string)
      ttl         = optional(number, 3600)
    })), {})
    aaaa        = optional(map(object({
      name        = string
      records     = list(string)
      ttl         = optional(number, 3600)
    })), {})
    caa         = optional(map(object({
      name        = string
      record      = list(string)
      ttl         = optional(number, 3600)
    })), {})
    cname       = optional(map(object({
      name        = string
      record      = string
      ttl         = optional(number, 3600)
    })), {})
    mx          = optional(map(object({
      name        = string
      record      = list(string)
      ttl         = optional(number, 3600)
    })), {})
    ns          = optional(map(object({
      name        = string
      records     = list(string)
      ttl         = optional(number, 172800)
    })), {})
    srv         = optional(map(object({
      name        = string
      record      = list(string)
      ttl         = optional(number, 3600)
    })), {})
    txt         = optional(map(object({
      name        = string
      record      = list(string)
      ttl         = optional(number, 3600)
    })), {})
  })
  default     = {}
}