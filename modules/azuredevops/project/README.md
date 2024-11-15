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
| <a name="requirement_azuredevops"></a> [microsoft\/azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project) | resource |
| [azuredevops_group_membership.project_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/group_membership) | resource |
| [azuredevops_team_administrators.team_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team_administrators) | resource |
| [azuredevops_project_pipeline_settings.project_pipeline_settings](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project_pipeline_settings) | resource |


### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | project main variable with resource attributes | <pre>type        = object({<br>  name                    = string<br>  description             = optional(string, null)<br>  features                = optional(object({<br>    artifacts               = optional(string, "disabled")<br>    boards                  = optional(string, "enabled")<br>    repositories            = optional(string, "enabled")<br>    pipelines               = optional(string, "disabled")<br>    testplans               = optional(string, "disabled")<br>  }), {})<br>  visibility              = optional(string, "private")<br>  version_control         = optional(string, "Git")<br>  work_item_template      = optional(string, "Agile")<br>  project_administrators  = optional(object({<br>    users                   = optional(list(string), null)<br>    mode                    = optional(string, "overwrite")<br>  }), {})<br>})</pre> | none | yes |
| <a name="input_team_administrator"></a> [team\_administrator](#input\_team\_administrator) | project's default team administrators | <pre>object({<br>  name = optional(list(string), ["Project Administrators"])<br>  mode = optional(string, "overwrite")<br>})</pre> | <pre>object({<br>  name = ["Project Administrators"]<br>  mode = "overwrite"<br>})</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_project"></a> [project](#output\_project) | list of all exported attributes values from the project resource |
| <a name="output_group_membership_project_administrators"></a> [group\_membership\_project\_administrators](#output\_group\_membership\_project\_administrators) | list of all exported attribute values from the group_membership.project_administrators resource |
| <a name="output_project_pipeline_settings"></a> [project\_pipeline\_settings](#output\_project\_pipeline\_settings) | list of all exported attributes values from the project_pipeline_settings resource |
| <a name="output_team"></a> [team](#output\_team) | list of all exported attributes values from the (project's default) team resource |
| <a name="output_git_repository"></a> [git\_repository](#output\_git\_repository) | list of all exported attributes values from the (project's default) git_repository resource |
| <a name="output_import_id_team"></a> [import\_id\_team](#output\_import\_id\_team) | output of a formatted id needed to import the team resource to Terraform state |
| <a name="output_import_id_git_repository"></a> [import\_id\_git\_repository](#output\_import\_id\_git\_repository) | output of a formatted id needed to import the git_resource resource to Terraform state |

### Known Issues

<details>
<summary><b>Default <i>git_repository</i> resource automatically created with a project</b></summary>

######
A new created project in Azure Devops automatically generates a repository labeled as <i>&lt;name of project&gt;</i> (if repository feature is enabled). This is by design and can't be suppressed.  
  
If the default resource should or need to be used, it can only be managed if it is imported. The *project* module provides explicit output to use as import sources.  

*Best Practice*/*Recommendation*: It is recommended not to use the default repository and therefore, it is not necessary to import this resource into Terraform state. Instead, it is recommended to disable the repository manually.  

If an import is necessary one can use the following code snippet:

```
import {
  id = module.<i>&lt;project-module-name&gt;</i>.import_id_git_repository
  to = module.<i>&lt;git-repository-module-name&gt;</i>.azuredevops_git_repository.git_repository
}
```

> **[IMPORTANT]**  
> Remove the 'import' block from code after importing the resource into Terraform state!

If the default repository has been imported into Terraform state, deleting a project via *terraform destroy* command will fail. This is also by design because the default repository resource cannot be deleted on its own but has to be deleted via the project resource. Remove the imported resource manually from Terraform state before executing the destroy-command to workaround this:  

```
terraform state rm module.<i>&lt;git-repository-module-name&gt;</i>.azuredevops_git_repository.git_repository
```

</details>

<details>
<summary><b>Default <i>team</i> resource automatically created with a project</b></summary>

######
A new created project in Azure Devops automatically generates a default team labeled as <i>&lt;name of project&gt; Team</i>. This is by design and can't be suppressed.  
  
If the default resource should or need to be used, it can only be managed if it is imported. The *project* module provides explicit output to use as import sources.  

*Best Practice*/*Recommendation*: The *azuredevops_team* resource can only manage the team's name, description, administrators and members. Name and description should not be changed for the defaul team. Administrators and members can be managed using *azuredevops_team_administrators* and *azuredevops_team_members* resources. Therefore, it is not necessary to import the team into Terraform state.  

If an import is necessary one can use the following code snippet:

```
import {
  id = module.<i>&lt;project-module-name&gt;</i>.import_id_team
  to = module.<i>&lt;team-module-name&gt;</i>.azuredevops_team.team
}
```

> **[IMPORTANT]**  
> Remove the 'import' block from code after importing the resource into Terraform state!

If the default team has been imported into Terraform state, deleting a project via *terraform destroy* command will fail. This is also by design because the default team resource cannot be deleted on their own but has to be deleted via the project resource. Remove the imported resource manually from Terraform state before executing the destroy-command to workaround this:  

```
terraform state rm module.<i>&lt;team-module-name&gt;</i>.azuredevops_team.team
```

</details>
  
---
  
[Back to README.md](../README.md)  
