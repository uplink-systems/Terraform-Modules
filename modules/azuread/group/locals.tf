####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

# This is used to build the group's member list containing member user ids, service principal ids and member group ids...
locals {
  members = concat(data.azuread_users.members.object_ids,data.azuread_groups.members.object_ids,data.azuread_service_principals.members.object_ids)
}

# This is used to buld the administrative units list containing administrative unit's object ids...
locals {
  administrative_unit_ids = [for unit in data.azuread_administrative_unit.administrative_unit : unit.object_id]
}
