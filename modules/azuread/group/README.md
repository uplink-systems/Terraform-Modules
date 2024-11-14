## Module Description

### Purpose

This module is intended to create groups in Azure AD. The module scopes all types/combination of groups (Security/Unified, Assigned/Dynamic) in one resource depending on the variable values provided.

### Example

For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuread/group

### Versions

This module was tested with the following Terraform and provider versions before release:

<pre>
terraform {
  required_version = "= 1.9.6"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 3.0.2"
    }
  }
}
</pre>

Other version might work but are not tested by the developer of the module.

### Files

#### main.tf: attribute 'lifecycle'

Changes to the variable attribute 'var.group.administrative_unit_ids' is ignored via lifecycle parameters to avoid conflicts when administrative unit memberships are also managed via 'azuread_administrative_unit' and/or 'azuread_administrative_unit_member' resource types. The lifecycle parameter can be customized if membership is only managed via 'azuread_group' resources.  
  
Accidentially changing the variable attribute 'var.group.behaviors' forces resource re-creation and therefore a change in code is ignored. If attribute shall be changed, delete the old resource and create a new resource explicitly via code.  

### Variables

#### 'var.group.administrative_units'

The variable attribute <i>var.group.administrative_units</i> represents a list of one or more administrative unit display names. The module translates the names to its corresponding object IDs via data query and merges the results to a list of IDs.

#### 'var.group.members.users', 'var.group.members.service_principal' &amp; 'var.group.members.group'

The variable attributes <i>var.group.members.user</i>, <i>var.group.members.service_principal</i> and <i>var.group.members.group</i> represent a list of one or more user principal names and/or service principal display names and/or group display names. The module translates the user principal names and/or the service principal display names and/or group display names to their corresponding object IDs via data queries and merges the results to a list of IDs.

### Outputs

The module currently generates the following outputs:   
1) <b>azuread_group</b> => list of all exported attributes values from all groups  
2) <b>azuread_group_display_name</b> => list of exported display_name attribute values from all groups  
3) <b>azuread_group_object_id</b> => list of exported object_id attribute values from all groups  

#### Using module output in root module

##### Examples

Output - IDs of all groups using 'azuread_group_object_id' output:

<pre>
output "azuread_group_id_all_groups" {
    value = toset([
        for object_id in module.azuread_group : object_id.azuread_group_object_id
    ])
}
</pre>

Output - ID of a single specified group using 'azuread_group_object_id' output:

<pre>
output "azuread_group_id_group_1" {
    value = module.azuread_group["<i>&lt;Terraform-Resource-Name&gt;</i>"].azuread_group_object_id
}
</pre>

### Known Issues

<details>
<summary><b>azuread_group attribute 'var.group.auto_subscribe_new_members'</b></summary>
The variable attribute <i>var.group.auto_subscribe_new_members</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
</details>

<details>
<summary><b>azuread_group attribute 'var.group.mail.external_senders_allowed'</b></summary>
The variable attribute <i>var.group.mail.external_senders_allowed</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
</details>

<details>
<summary><b>azuread_group attribute 'var.group.mail.hide_from_address_lists'</b></summary>
The variable attribute <i>var.group.mail.hide_from_address_lists</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group 
</details>

<details>
<summary><b>azuread_group attribute 'var.group.mail.hide_from_outlook_clients'</b></summary>
The variable attribute <i>var.group.mail.hide_from_outlook_clients</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
</details>

<details>
<summary><b>azuread_group attribute 'var.group.owners'</b></summary>
If the group is initially owned by a service principal and you add a user to the owners, you are not able to remove the user from the owners again. At least one user has to stay owner.  
https://github.com/hashicorp/terraform-provider-azuread/issues/464  
https://github.com/microsoftgraph/msgraph-metadata/issues/92  
</details>