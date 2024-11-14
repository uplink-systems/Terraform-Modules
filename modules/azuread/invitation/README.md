## Module 'invitation'

### Description

This module is intended to create invitations for guest accounts in Azure AD.

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [hashicorpe\/azuread](#requirement\_azuread) | ~> 3.0 |

### Resources

| Name | Type |
|------|------|
| [azuread_invitation.invitation](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/invitation) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_invitation"></a> [invitation](#input\_invitation) | 'var.invitation' is the main variable for azuread_invitation resource settings | <pre>type        = object({<br>  user_display_name   = string<br>  user_email_address  = string<br>  redirect_url        = optional(string, "https://microsoft365.com")<br>  user_type           = optional(string, null)<br>  message             = optional(object({<br>    enabled               = optional(bool, true)<br>    additional_recipients = optional(list(string), null)<br>    body                  = optional(string, null)<br>    language              = optional(string, null)<br>  }), { enabled = false })<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azuread_invitations"></a> [azuread\_invitations](#output\_azuread\_invitations) | list of all exported attributes values from all invitations |
| <a name="output_azuread_invitation_user_id"></a> [azuread\_invitation\_user\_id](#output\_azuread\_invitation\_user\_id) | list of exported user_id attribute values from all invitations |

<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - IDs of all groups using 'azuread_invitation_user_id' output:

```
output "azuread_invitation_all_user_ids" {
    value = toset([
        for user_id in module.azuread_invitation :user_id.azuread_invitation_user_id
    ])
}
```

Output - ID of a single specified group using 'azuread_invitation_user_id' output:

```
output "azuread_invitation_user_id_1" {
    value = module.azuread_invitation["<i>&lt;Terraform-Resource-Name&gt;</i>"].azuread_invitation_user_id
}
```
</details>

### Known Issues

<details>
<summary><b>n/a</b></summary>

######
  
</details>
  
---
  
[Back to README.md](../README.md)  