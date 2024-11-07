# README

## Purpose

These modules are intended to create and manage Azure DevOps resources related to projects following my business needs standards. Resources related to Azure DevOps organisation settings are out ouf scope.  

## Example

For an example how to use the modules please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuredevops  

## Modules

### Module 'project'

The module <i>project</i> manages Azure DevOps projects.  
This includes the project itself as well as dependant project resources (e.g. project pipeline settings).  

> [!NOTE]
> A default team and a default repository are automatically generated when the project itself is created.  
> The module contains two data sources to output their attributes from the module as well as two formatted outputs to use as import Ids.  
> For further info and why/how to make use of the output: see "Known Issues".  

#### Open issues

n/a  

#### Outputs

The module currently generates the following outputs:  

1) <b>project</b> => list of all exported attributes values from the project resource  
2) <b>project_pipeline_settings</b> => list of all exported attributes values from the project_pipeline_settings resource  
3) <b>team</b> => list of all exported attributes values from the team data source  
4) <b>git_repository</b> => list of all exported attributes values from the git_repository data source  
5) <b>import_id_team</b> => output of a formatted id needed to import the team resource to Terraform state  
6) <b>import_id_git_repository</b> => output of a formatted id needed to import the git_resource resource to Terraform state  


### Module 'git_repository'

The module <i>git_repository</i> manages Azure DevOps project Git repositories.  

#### Open issues

n/a  

#### Outputs

The module currently generates the following outputs:  

1) <b>git_repository</b> => list of all exported attributes values from the git_repository resource  

### Module 'team'

> [!NOTE]
> The <b>team</b> module is released but has open issues.  

The module <i>team</i> manages Azure DevOps project teams.  
This includes the team itself as well as dependant repository resources (e.g. team administrators or team members).  

#### Open issues

1) Only one group each can be configured as members or administrators, even though the attributes are lists and therefore support multiple groups.  
2) Two different data sources are necessary to differentiate between members and administrators.  

The reason for both issues is that currently <b>azuredevops_group</b> data source must be used, even though <b>azuredevops_groups</b> data source is available for handling lists. Unfortunately the data source has no option to further restrict the output, except for the project itself. Instead, all groups or all project groups are always put out.   

<pre>
data "azuredevops_groups" "project_groups" {
  project_id      = var.team.project_id
  depends_on      = [ azuredevops_team.team ]
}
</pre>

#### Outputs

The module currently generates the following outputs:  

1) <b>team</b> => list of all exported attributes values from the team resource  

### Module 'repository_policy'

> [!NOTE]
> The <b>repository_policy</b> module is under development but not released yet.  

The module <i>repository_policy</i> manages Azure DevOps project and/or repository policies.   

#### Outputs

The module currently generates the following outputs:  

1) <b>repository_policy_author_email_pattern</b> => list of all exported attributes values from the repository_policy_author_email_pattern resource  
2) <b>repository_policy_case_enforcement</b> => list of all exported attributes values from the repository_policy_case_enforcement resource  
3) <b>repository_policy_file_path_pattern</b> => list of all exported attributes values from the repository_policy_file_path_pattern resource  
4) <b>repository_policy_max_file_size</b> => list of all exported attributes values from the repository_policy_max_file_size resource  
5) <b>repository_policy_max_path_length</b> => list of all exported attributes values from the repository_policy_max_path_length resource  
6) <b>repository_policy_reserved_names</b> => list of all exported attributes values from the repository_policy_reserved_names resource  

### Module 'wiki'

> [!NOTE]
> The <b>wiki</b> module is under development but not released yet and has open issues.  

The module <i>wiki</i> manages Azure DevOps wikis.  
This includes project wikis as well as code wikis.  

#### Open issues

1) The module is not tested yet.

#### Outputs

The module currently generates the following outputs:  

1) <b>wiki</b> => list of all exported attributes values from the wiki resource  

### Module 'workitem'

The module <i>workitems</i> manages Azure DevOps project work items.  
This includes all types of work items for projects with all kinds of work item templates.  

#### Outputs

The module currently generates the following outputs:  

1) <b>workitem</b> => list of all exported attributes values from the workitem resource  

#### Notes

<i>Variable attribute 'type'</i>  
  
The valid and available values for the 'type' attribute depends on project's used work_item_template, e.g.:  
  
<pre>
Agile -> "Bug", "Epic", "Feature", "Issue", "Task", "Test Case", "User Story"
Basic -> "Epic", "Issue", "Task"
Scrum -> "Bug", "Epic", "Feature", "Impediment", "Product backlog item", "Task"
CMMI  -> "Bug", "Change Request", "Epic", "Feature", "Issue", "Requirment", "Review", "Risk", "Task"
</pre>
  
<i>Variable attribute 'custom_fields'</i>  
  
The module supports setting custom fields. The custom field definitions must be created in the project before using them in the module:  
https://learn.microsoft.com/en-us/azure/devops/organizations/settings/work/add-custom-field  
  
Use of custom fields:  
  
<pre>
...
custom_field = {
  "&lt;custom_field_name_1&gt;" : "&lt;value&gt;"
  "&lt;custom_field_name_2&gt;" : "&lt;value&gt;"
  "&lt;custom_field_name_3&gt;" : "&lt;value&gt;"
  "..." : "..."
}
...
</pre>

## Variables

n/a

## Known Issues
 
The modules are affected by the following known issues:  
 
### AzDO resources created with a project by default
 
A new created project in Azure Devops automatically generates a repository labeled as <i>&lt;name of project&gt;</i> (if repository feature is enabled) and a default team labeled as <i>&lt;name of project&gt; Team</i>. This is by design and can't be suppressed.  
  
If these resources should or need to be used, they can only be managed if they are imported. The 'project' module provides explicit outputs to use as import sources.  
  
> [!TIP]
> It is best practice not to use the default resources and therefore, it is not necessary to import these resources to Terraform state. Instead, it is recommended to disable the repository manually and not use the team.  

#### Import: Team & Git Repository

<pre>
import {
  id = module.<i>&lt;project-module-name&gt;</i>.import_id_team
  to = module.<i>&lt;team-module-name&gt;</i>.azuredevops_team.team
}
</pre>

<pre>
import {
  id = module.<i>&lt;project-module-name&gt;</i>.import_id_git_repository
  to = module.<i>&lt;git-repository-module-name&gt;</i>.azuredevops_git_repository.git_repository
}
</pre>

> [!IMPORTANT]
> Remove the 'import' blocks from code after importing the resources to Terraform state!

#### Destroy deployment (terraform destroy)

If the default repository and team have been imported to Terraform state, deleting a project via <i>terraform destroy</i> command will fail. This is also by design because the default repository/team resources cannot be deleted on their own but have to be deleted via the project resource. Remove the imported resources manually from Terraform state before executing the destroy-command to workaroung this:  

<pre>
terraform state rm module.<i>&lt;team-module-name&gt;</i>.azuredevops_team.team
terraform state rm module.<i>&lt;git-repository-module-name&gt;</i>.azuredevops_git_repository.git_repository
</pre>
