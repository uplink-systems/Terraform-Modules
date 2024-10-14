####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "name" {
  description = "Role's display name"
}
variable "description" {
  description = "Role's description"
}
variable "scope" {
  description = "Role's scoped management group or subscription"
}
variable "assignable_scopes" {
  description = "Role's assignable scoped management groups and/or subscriptions"
}
variable "permissions" {
  description = "Role's permissions"
}