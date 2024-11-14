## Module 'project_team'

> [!NOTE]
> The **project_team** module has known issues **without** impact on the module's functionality.

### Description

The module **project_team** manages Azure DevOps project teams. This includes the team itself as well as dependant repository resources (e.g. team administrators or team members).  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuredevops"></a> [microsoft\/azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_team.team](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team) | resource |
| [azuredevops_team_administrators.team_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team_administrators) | resource |
| [azuredevops_team_members.team_members](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team_members) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_team"></a> [team](#input\_team) | team main variable with resource attributes | <pre>type = object({<br>  project_id = string<br>  name = string<br>  description = optional(string, null)<br>})<br></pre> | none | yes |
| <a name="input_team_administrators"></a> [team\_administrators](#input\_team\_administrators) | team_administrators main variable with resource attributes | <pre>type = object({<br>  name = optional(list(string), ["Project Administrators"])<br>  mode = optional(string, "add")<br>})<br></pre> | <pre>type = object({<br>  name = ["Project Administrators"]<br>  mode = "add"<br>})<br></pre> | no |
| <a name="input_team_members"></a> [team\_members](#input\_team\_members) | team_members main variable with resource attributes | <pre>type = object({<br>  name = optional(list(string), ["Readers"])<br>  mode = optional(string, "add")<br>})<br></pre> | <pre>type = object({<br>  name = ["Readers"]<br>  mode = "add"<br>})<br></pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_team"></a> [team](#output\_team) | list of all exported attributes values from the team resource |
| <a name="output_team_administrators"></a> [team\_administrators](#output\_team\_administrators) | list of all exported attributes values from the team_administrators resource |
| <a name="output_team_members"></a> [team\_members](#output\_team\_members) | list of all exported attributes values from the team_members resource |

### Known Issues

<details>
<summary><b><i>azuredevops_team_administrators</i> shows unnecessary changes in <i>terraform plan</i> mode</b></summary>

######
Running <i>terraform plan</i> command until running <i>terraform apply</i> always results in a plan output showing changes when managing teams. During plan mode Terraform is not able to recognize that the data source results for team_administrators are equal to the settings in the code.  
Running <i>terraform apply</i> does NOT process these changes because Terraform recognizes that no changes are necessary in apply mode.  
This also affects the default team_administrators resource in the project module.  
  
</details>

<details>
<summary><b><i>azuredevops_team_members</i> shows unnecessary changes in <i>terraform plan</i> mode</b></summary>

######
Running <i>terraform plan</i> command until running <i>terraform apply</i> always results in a plan output showing changes when managing teams. During plan mode Terraform is not able to recognize that the data source results for team_members are equal to the settings in the code.  
Running <i>terraform apply</i> does NOT process these changes because Terraform recognizes that no changes are necessary in apply mode.  .  
  
</details>
  
---
  
[Back to README.md](../README.md)  
