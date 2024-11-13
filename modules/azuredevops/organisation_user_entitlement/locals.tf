####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

# build a list of flattened member users from the group list
# => flattening "skips" multiple group memberships of users and only lists them once
locals {
  azuread_group_members = distinct(flatten([ for group in data.azuread_group.group : [ for member in group.members : { item = member } ] ]))
}
