## Module 'project'

> [!NOTE]  
> The **project** module has known issues **without** impact on the module's functionality. 

### Description

The module **project** manages Azure DevOps projects. This includes the project itself as well as some dependant project resources.  

> [!NOTE]  
> A default (uninitialized) repository and a default team are automatically generated when the project itself is created. The module contains two data sources to output the team- and repository-attributes from the module as well as two formatted outputs to use as import Ids. Furthermore, the module manages the administrators of the default team. If no administrator config is passed to the module, a default configuration applies adding the "Project Administrators" group as administrators.  
> For further info and why/how to make use of the output or not: see "Known Issues".  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_powershell"></a> [powershell](#requirement\_powershell) | >= 7.0 |
| <a name="requirement_azuredevops"></a> [microsoft\/azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project) | resource |
| [azuredevops_group_membership.project_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/group_membership) | resource |
| [azuredevops_team_administrators.team_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team_administrators) | resource |
| [azuredevops_project_pipeline_settings.project_pipeline_settings](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project_pipeline_settings) | resource |
| [terraform_data.initialize_default_repository](https://developer.hashicorp.com/terraform/language/resources/terraform-data) | managed resource |
| [terraform_data.disable_default_repository](https://developer.hashicorp.com/terraform/language/resources/terraform-data) | managed resource |
| [terraform_data.enable_default_repository](https://developer.hashicorp.com/terraform/language/resources/terraform-data) | managed resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | organization's main variable with attributes required for the project's resources | <pre>type        = object({<br>  personal_access_token   = string<br>})<br></pre> | none | yes |
| <a name="input_project"></a> [project](#input\_project) | project main variable with resource attributes | <pre>type        = object({<br>  name                    = string<br>  description             = optional(string, null)<br>  features                = optional(object({<br>    artifacts               = optional(string, "disabled")<br>    boards                  = optional(string, "enabled")<br>    repositories            = optional(string, "enabled")<br>    pipelines               = optional(string, "disabled")<br>    testplans               = optional(string, "disabled")<br>  }), {})<br>  visibility              = optional(string, "private")<br>  version_control         = optional(string, "Git")<br>  work_item_template      = optional(string, "Agile")<br>  project_administrators  = optional(object({<br>    users                   = optional(list(string), null)<br>    mode                    = optional(string, "overwrite")<br>  }), {})<br>  disable_default_repository  = optional(bool, false)<br>  enable_default_repository  = optional(bool, false)<br>})</pre> | none | yes |
| <a name="input_team_administrators"></a> [team\_administrators](#input\_team\_administrators) | project's default team administrators | <pre>object({<br>  name = optional(list(string), ["Project Administrators"])<br>  mode = optional(string, "overwrite")<br>})</pre> | <pre>name = ["Project Administrators"]<br>mode = "overwrite"</pre> | no |
| <a name="input_project_pipeline_settings"></a> [team\_project\_pipeline\_settings](#input\_project\_pipeline\_settings) | project's pipeline settings | <pre>type        = object({<br>  enforce_job_scope                     = optional(bool, true)<br>  enforce_job_scope_for_release         = optional(bool, true)<br>  enforce_referenced_repo_scoped_token  = optional(bool, true)<br>  enforce_settable_var                  = optional(bool, true)<br>  publish_pipeline_metadata             = optional(bool, false)<br>  status_badges_are_private             = optional(bool, true)<br>})<br></pre> | <pre>enforce_job_scope                     = true<br>enforce_job_scope_for_release         = true<br>enforce_referenced_repo_scoped_token  = true<br>enforce_settable_var                  = true<br>publish_pipeline_metadata             = false<br>status_badges_are_private             = true</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_project"></a> [project](#output\_project) | list of all exported attributes values from the project resource |
| <a name="output_group_membership_project_administrators"></a> [group\_membership\_project\_administrators](#output\_group\_membership\_project\_administrators) | list of all exported attribute values from the group_membership.project_administrators resource |
| <a name="output_project_pipeline_settings"></a> [project\_pipeline\_settings](#output\_project\_pipeline\_settings) | list of all exported attributes values from the project_pipeline_settings resource |
| <a name="output_team"></a> [team](#output\_team) | list of all exported attributes values from the (project's default) team resource |
| <a name="output_git_repository"></a> [git\_repository](#output\_git\_repository) | list of all exported attributes values from the (project's default) git_repository resource |
| <a name="output_import_id_team"></a> [import\_id\_team](#output\_import\_id\_team) | formatted id needed to import the team resource to Terraform state |
| <a name="output_import_id_git_repository"></a> [import\_id\_git\_repository](#output\_import\_id\_git\_repository) | formatted id needed to import the git_resource resource to Terraform state |

### Known Issues

<details>
<summary><b>Default <i>git_repository</i> resource automatically created with a project</b></summary>

######
A new created project in Azure Devops automatically generates an uninitialized repository labeled as <i>&lt;name of project&gt;</i>. This is by design and can't be suppressed.  
  
The module initializes the default repository but if it shall or need to be managed afterwards, it needs to be imported. The *project* module provides explicit output to use as import source but in most cases it is not necessary to further change repository settings.  

Optionally it is possible to disable the repository. This can be done by setting the variable *disable_default_repository* to *true*.  

If an import is necessary one can use the following code snippet:

```
import {
  id = module.<project-module-name>.import_id_git_repository
  to = module.<git-repository-module-name>.azuredevops_git_repository.git_repository
}
```

If the default repository has been imported into Terraform state, deleting a project via *terraform destroy* command will fail. This is also by design because the default repository resource cannot be deleted on its own but has to be deleted via the project resource. Remove the imported resource manually from Terraform state before executing the destroy-command to workaround this:  

```
terraform state rm module.<git-repository-module-name>.azuredevops_git_repository.git_repository
```

</details>

<details>
<summary><b>Default <i>team</i> resource automatically created with a project</b></summary>

######
A new created project in Azure Devops automatically generates a default team labeled as <i>&lt;name of project&gt; Team</i>. This is by design and can't be suppressed.  
  
If the default resource shall or need to be used, it can only be managed if it is imported. The *project* module provides explicit output to use as import source.  

The *azuredevops_team* resource can only manage the team's name, description, administrators and members. Name and description should not be changed for the default team. Administrators and members can be managed using *azuredevops_team_administrators* and *azuredevops_team_members* resources. Therefore, it is not necessary to import the team into Terraform state.  

If an import is needed one can use the following code snippet:

```
import {
  id = module.<project-module-name>.import_id_team
  to = module.<team-module-name>.azuredevops_team.team
}
```

If the default team has been imported into Terraform state, deleting a project via *terraform destroy* command will fail. This is also by design because the default team resource cannot be deleted on their own but has to be deleted via the project resource. Remove the imported resource manually from Terraform state before executing the destroy-command to workaround this:  

```
terraform state rm module.<team-module-name>.azuredevops_team.team
```

</details>

<details>
<summary><b>Initialize the default repository</b></summary>

######
The module contains an option to initialize the automatically generated default repository which is enabled by default. It is triggered via *var.project.initialize_default_repository* variable attribute.  

Setting the *var.project.initialize_default_repository* value to *false* skips the init process. This can be useful for example if the project resource is an imported resource. In this case the init should be disabled to prevent the module from accidentially deleting or overwriting exisiting resources.  
  
Please note:  
**DO NOT** change the *var.project.initialize_default_repository* value **after** the code for the resource has been applied for the first time. This can lead to unexpected results and even to data loss.  

</details>

<details>
<summary><b>Disable or enable the default repository</b></summary>

######
The module contains an option to disable/enable the automatically generated default repository. It is triggered via *var.project.disable_default_repository* and *var.project.enable_default_repository* variable attributes.

Setting the *var.project.disable_default_repository* value to *true* triggers the resource *terraform_data.disable_default_repository* and disables the repository whereas setting the attribute's value to *false* or unset the attribute's value only destroys the resource from state but **NOT** enable the repository again.  
Setting the *var.project.enable_default_repository* value to *true* triggers the resource *terraform_data.enable_default_repository* and enables the repository whereas setting the attribute's value to *false* or unset the attribute's value only destroys the resource from state but **NOT** disable the repository again.
This "double-resource" procedure is necessary because the option is implemented using *local-exec* provisioner with PowerShell which can only execute kind of **one-way** commands and does not have a "rollback" option.  
  
Setting *both* attributes to *true* causes the module to stop as it has a validation rule to prevent conflicts for these attributes.

</details>
  
---
  
[Back to README.md](../README.md)  
