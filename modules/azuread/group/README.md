## Module 'group'

### Description

This module is intended to create groups in Azure AD. The module scopes all types/combination of groups (Security/Unified, Assigned/Dynamic) in one resource depending on the variable values provided.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [hashicorp\/azuread](#requirement\_azuread) | ~> 3.0 |

### Resources

| Name | Type |
|------|------|
| [azuread_group.group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group"></a> [user](#input\_group) | 'var.group' is the main variable for azuread_group resource settings | <pre>type        = object({<br>  display_name                = string<br>  administrative_units        = optional(set(string), null)<br>  assignable_to_role          = optional(bool, false)<br>  auto_subscribe_new_members  = optional(bool, false)<br>  behaviors                   = optional(set(string), null)<br>  description                 = optional(string)<br>  dynamic_membership          = optional(object({<br>    enabled                     = optional(bool, true)<br>    rule                        = optional(string, null)<br>  }), { enabled = false })<br>  mail                        = optional(object({<br>    mail_enabled                = optional(bool, true)<br>    mail_nickname               = optional(string, null)<br>    external_senders_allowed    = optional(bool, false)<br>    hide_from_address_lists     = optional(bool, false)<br>    hide_from_outlook_clients   = optional(bool, false)<br>  }), { mail_enabled = false })<br>  members                     = optional(object({<br>    enabled                     = optional(bool, true)<br>    group                       = optional(set(string), [])<br>    service_principal           = optional(set(string), [])<br>    user                        = optional(set(string), [])<br>  }), { enabled = false })<br>  owners                      = optional(set(string), [])<br>  prevent_duplicate_names     = optional(bool, true)<br>  provisioning_options        = optional(set(string), null)<br>  security_enabled            = optional(bool, true)<br>  theme                       = optional(string, null)<br>  types                       = optional(list(string), null)<br>  visibility                  = optional(string, null)<br>  writeback                   = optional(object({<br>    writeback_enabled           = optional(bool, true)<br>    onpremises_group_type       = optional(string, "UniversalSecurityGroup")<br>  }), { writeback_enabled = false })<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azuread_group"></a> [azuread\_group](#output\_azuread\_group) | list of all exported attributes values from from all groups |
| <a name="output_azuread_group_display_name"></a> [azuread\_group\_display\_name](#output\_azuread\_group\_display\_name) | list of exported display_name attribute values from all groups |
| <a name="output_azuread_group_object_id"></a> [azuread\_group\_object\_id](#output\_azuread\_group\_object\_id) | list of exported object_id attribute values from all groups |

<details>
<summary><b>Using module output in root module</b></summary>

Output - IDs of all groups using 'azuread_group_object_id' output:

```
output "azuread_group_id_all_groups" {
    value = toset([
        for object_id in module.azuread_group : object_id.azuread_group_object_id
    ])
}
```

Output - ID of a single specified group using 'azuread_group_object_id' output:

```
output "azuread_group_id_group_1" {
    value = module.azuread_group["<i>&lt;Terraform-Resource-Name&gt;</i>"].azuread_group_object_id
}
```
</details>

### Known Issues

<details>
<summary><b>azuread_group attribute 'var.group.auto_subscribe_new_members'</b></summary>

######
The variable attribute <i>var.group.auto_subscribe_new_members</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
######
</details>

<details>
<summary><b>azuread_group attribute 'var.group.mail.external_senders_allowed'</b></summary>

######
The variable attribute <i>var.group.mail.external_senders_allowed</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
######
</details>

<details>
<summary><b>azuread_group attribute 'var.group.mail.hide_from_address_lists'</b></summary>

######
The variable attribute <i>var.group.mail.hide_from_address_lists</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
######
</details>

<details>
<summary><b>azuread_group attribute 'var.group.mail.hide_from_outlook_clients'</b></summary>

######
The variable attribute <i>var.group.mail.hide_from_outlook_clients</i> can only be set when authenticating as a Member user of the tenant and not when authenticating as a Guest user or as a service principal. Please see the <a href="https://docs.microsoft.com/en-us/graph/known-issues#groups">Microsoft Graph Known Issues</a> documentation.  
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group  
######
</details>

<details>
<summary><b>azuread_group attribute 'var.group.owners'</b></summary>

######  
If the group is initially owned by a service principal and you add a user to the owners, you are not able to remove the user from the owners again. At least one user has to stay owner.  
https://github.com/hashicorp/terraform-provider-azuread/issues/464  
https://github.com/microsoftgraph/msgraph-metadata/issues/92  
######
</details>
  
## Notes

### main.tf attributes

#### 'lifecycle'

Changes to the variable attribute *var.group.administrative_unit_ids* is ignored via lifecycle parameters to avoid conflicts when administrative unit memberships are also managed via *azuread_administrative_unit* and/or *azuread_administrative_unit_member* resource types. The lifecycle parameter can be customized if membership is only managed via *azuread_group* resources.  
  
Accidentially changing the variable attribute *var.group.behaviors* forces resource re-creation and therefore a change in code is ignored. If attribute shall be changed, delete the old resource and create a new resource explicitly via code.  

### Variables / Locals

#### 'var.group.administrative_units'

The variable attribute *var.group.administrative_units* represents a list of one or more administrative unit display names. The module translates the names to its corresponding object IDs via data query and merges the results to a list of IDs.

#### 'var.group.members.users', 'var.group.members.service_principal' &amp; 'var.group.members.group'

The variable attributes *var.group.members.user*, *var.group.members.service_principal* and *var.group.members.group* represent a list of one or more user principal names and/or service principal display names and/or group display names. The module translates the user principal names and/or the service principal display names and/or group display names to their corresponding object IDs via data queries and merges the results to a list of IDs.
  
---
  
[Back to README.md](../README.md)  