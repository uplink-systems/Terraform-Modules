variable "display_name" {
  description = "Group's display name"
}
variable "description" {
  description = "Description for the group"
}
variable "administrative_unit_ids" {
  description = "ID(s) of adminitrative units"
}
variable "assignable_to_role" {
  description = "Can the group be used to assign it to an Entra ID admin role?"
}
variable "owners" {
    description = "Users to add as owner to the group"
}
variable "prevent_duplicate_names" {
  description = "Prevent duplicate group names?"
}
variable "rule" {
  description = "Group's rule to evaluate for membership assignement"
}
variable "security_enabled" {
  description = "Is the group a security enabled group?"
}