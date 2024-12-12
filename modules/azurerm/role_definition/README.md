## Module 'role_definition'

### Description

This module is intended to create custom roles in in Azure RM.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [hashicorp\/azurerm](#requirement\_azurerm) | ~> 4.0 |

### Resources

| Name | Type |
|------|------|
| [azurerm_role_definition.role_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_role_definition"></a> [role\_definition](#input\_role\_definition) | 'var.role_definition' is the main variable for azurerm_role_definition resource settings | <pre>type        = object({<br>  name                = string<br>  description         = optional(string, null)<br>  scope               = optional(string, null)<br>  assignable_scopes   = optional(list(string), [])<br>  permissions         = optional(object({<br>    enabled             = optional(bool, true)<br>    actions             = optional(list(string), [])<br>    data_actions        = optional(list(string), [])<br>    not_actions         = optional(list(string), [])<br>    not_data_actions    = optional(list(string), [])<br>  }), {enabled = false})<br>})<br></pre> | none | yes |
  
<details>
<summary><b>Using the variables in the root module</b></summary>

######
The following lines explain how the main variable in the root module has to be defined with minimum required settings if the module is used with a for_each loop to create multiple resources:  

<pre>
variable "role_definition" { }
module "azurerm_role_definition" {
  source                = "github.com/uplink-systems/Terraform-Modules//modules/azurerm/role_definition"
  for_each              = var.azurerm_role_definition
  role_definition       = each.value.role_definition
}
</pre>

</details>
  
### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_role_definition"></a> [azurerm\_role\_definition](#output\_azurerm\_role\_definition) | list of all exported attributes values from the azurerm_role_definition resources |
| <a name="output_azurerm_role_definition_id"></a> [azurerm\_role\_definition\_id](#output\_azurerm\_role\_definition\_id) | list of role_definitions_id attribute values from the azurerm_role_definition resources |
  
### Known Issues

<details>
<summary><b>Required permissions</b></summary>

######
Although the nature of the matter means that the account used for Terraform deployment requires elevated privileges, the built-in Contributor role is sufficient in most cases and therefore often used. However, the Contributor role has a number of NotActions such as *Microsoft.Authorization/\*/Write*. Without this permissions the following resources cannot be managed:
  
- Creating RBAC roles and assigning against scopes
  - azurerm_role_assignment
  - azurerm_role_definition
  - azurerm_user_assigned_identity
- Creating and assigning policy definitions and initiatives
  - azurerm_policy_assignment
  - azurerm_policy_definition
  
In this case, either the Owner role is required or a custom role needs to be in place with Contributor permissions and the following permissions in addition:
- "Microsoft.Authorization/*/Delete"
- "Microsoft.Authorization/*/Write"
- "Microsoft.Authorization/elevateAccess/Action"
  
</details>
  
---
  
[Back to README.md](../README.md)  
