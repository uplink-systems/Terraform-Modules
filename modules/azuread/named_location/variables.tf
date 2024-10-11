####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "display_name" {
  description = "Named location's display name"
}
variable "country" {
  description = "Variable for country-based named location"
}
variable "ip" {
  description = "Variable for ip-based named location"
}