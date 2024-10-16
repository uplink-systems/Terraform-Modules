## Module Description

### Purpose

This module is intended to create invitations for guest accounts in Azure AD.

### Example

For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuread/invitation

### Files

n/a

### Variables

n/a

### Outputs

The module currently generates the following outputs:  
1) <b>azuread_invitations</b> => list of all exported attributes values from all invitations
2) <b>azuread_invitation_user_id</b> => list of exported user_id attribute values from all invitations  

#### Using module output in root module

##### Examples

Output - IDs of all groups using 'azuread_invitation_user_id' output:

<pre>
output "azuread_invitation_all_user_ids" {
    value = toset([
        for user_id in module.azuread_invitation :user_id.azuread_invitation_user_id
    ])
}
</pre>

Output - ID of a single specified group using 'azuread_invitation_user_id' output:

<pre>
output "azuread_invitation_user_id_1" {
    value = module.azuread_invitation["<i>&lt;Terraform-Resource-Name&gt;</i>"].azuread_invitation_user_id
}
</pre>

### Known Issues

The module is affected by the following known issues:  

n/a  
