####################################################################################################
#   Variable declaration and Module calls:                                                         #
#   Azure AD assigned membership security groups                                                   #
####################################################################################################

variable "azuread_group_security_assigned" {
  description = "Azure AD assigned membership security group variables"
  type        = map(object({
    display_name              = string
    description               = optional(string, null)
    administrative_unit_ids   = optional(set(string), [])
    assignable_to_role        = optional(bool, false)
    member_groups             = optional(set(string), [])
    member_users              = optional(set(string), [])
    owners                    = optional(set(string), [])
    prevent_duplicate_names   = optional(bool, true)
    security_enabled          = optional(bool, true)
  }))
}

module "azuread_group_security_assigned" {
  source                    = "./modules/azuread_group_security_assigned"
  for_each                  = var.azuread_group_security_assigned
  display_name              = each.value.display_name
  description               = each.value.description
  administrative_unit_ids   = each.value.administrative_unit_ids
  assignable_to_role        = each.value.assignable_to_role
  member_groups             = each.value.member_groups
  member_users              = each.value.member_users
  owners                    = each.value.owners
  prevent_duplicate_names   = each.value.prevent_duplicate_names
  security_enabled          = each.value.security_enabled
}

####################################################################################################
#   Variable declaration and Module calls:                                                         #
#   Azure AD dynamic membership security groups                                                    #
####################################################################################################

variable "azuread_group_security_dynamic" {
  description = "Azure AD dynamic membership security group variables"
  type        = map(object({
    display_name              = string
    description               = optional(string)
    administrative_unit_ids   = optional(set(string), null)
    assignable_to_role        = optional(bool, false)
    owners                    = optional(set(string), [])
    prevent_duplicate_names   = optional(bool, true)
    rule                      = string
    security_enabled          = optional(bool, true)
  }))
}

module "azuread_group_security_dynamic" {
  source                    = "./modules/azuread_group_security_dynamic"
  for_each                  = var.azuread_group_security_dynamic
  display_name              = each.value.display_name
  description               = each.value.description
  administrative_unit_ids   = each.value.administrative_unit_ids
  assignable_to_role        = each.value.assignable_to_role
  owners                    = each.value.owners
  prevent_duplicate_names   = each.value.prevent_duplicate_names
  rule                      = each.value.rule
  security_enabled          = each.value.security_enabled
}