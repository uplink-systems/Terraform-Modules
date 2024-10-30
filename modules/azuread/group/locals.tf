####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  administrative_unit_ids = [for unit in data.azuread_administrative_unit.administrative_unit : unit.object_id]
  members                 = concat(data.azuread_users.members.object_ids,data.azuread_groups.members.object_ids,data.azuread_service_principals.members.object_ids)
}
