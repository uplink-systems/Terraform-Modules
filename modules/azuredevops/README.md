# README

## Purpose

These modules are intended to create and manage Azure DevOps resources related to projects following my business needs standards.  
This includes the following guidelines:  
* Projects
  * Project names can only contain the following characters: 0-9, a-z, A-Z and -
  * Project are always named as one of (depending in which of Uplink Systems' AzDO organisation the project is created):
    * EXT organisation: Customer Number to which the repositories will be created for  
    * INT organisation: <i>&lt;Project-Type&gt;</i>-<i>&lt;Project-Scope/Project-Purpose&gt;</i>, examples:  
      * Docu-Infrastruture --> Project to document infrastructure(s)  
      * DEV-Staging-INT --> Project for internal developments in staging phase ("playground" repository)  
      * IaC-Terraform --> Project for Infrastructure(s)-as-Code using Terraform  
  * Projects' default settings are (changes can be configured via module's variables):
    * enabled features are "Boards" and "Repositories"  
    * work item templaty is "Agile"  
    * visibility is "private"  
    * version control is "Git  
  * Repository policies are configured on project level by default.  
* Git Repository
  * Git Repositories are always named as "<i>&lt;Project-Name&gt;</i> <i>&lt;Git-Repository-Name&gt;</i>".
  * The project's automatically created default repository is not used and manually disabled.
* Team
  * Teams are always name as "<i>&lt;Project-Name&gt;</i> Team <i>&lt;Git-Repository-Name&gt;</i>".
  * The project's automatically created default team is not imported to Terraform state; instead, only the team administrators are configured with Terraform.
  
If you make use of the modules please either use the same guidelines or download and customize the modules to your needs.  
  
Resources related to Azure DevOps organisation settings are out ouf scope.  

## Example

For an example how to use the modules please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuredevops  

## Modules

### Module 'project'

The module <i>project</i> manages Azure DevOps projects.  
This includes the project itself as well as some dependant project resources. E.g. the module can configure:  
1) <i>Project Administrators</i> group membership (user)
2) Default Team team-administrators (groups)
3) Project pipeline settings

> [!NOTE]
> A default repository and a default team are automatically generated when the project itself is created. The module contains two data sources to output the team- and repository-attributes from the module as well as two formatted outputs to use as import Ids. Furthermore, the module manages the administrators of the default team. If no administrator config is passed to the module, a default configuration applies adding the "Contributors" group as administrators.  
> For further info and why/how to make use of the output or not: see "Known Issues".  

#### Known Issues / Open Issues

##### <i>git_repository</i> and <i>team</i> resources created with a project by default
 
A new created project in Azure Devops automatically generates a repository labeled as <i>&lt;name of project&gt;</i> (if repository feature is enabled) and a default team labeled as <i>&lt;name of project&gt; Team</i>. This is by design and can't be suppressed.  
  
If the default resources should or need to be used, they can only be managed if they are imported. The 'project' module provides explicit outputs to use as import sources.  

> [!TIP]
> Default repository: It is best practice not to use the default repository and therefore, it is not necessary to import this resource to Terraform state. Instead, it is recommended to disable the repository manually.  
> Default team: The <i>azuredevops_team</i> resource can only manage the team's name, description, administrators and members. Name and description should not be changed for the defaul team. Administrators and members can be managed using <i>azuredevops_team_administrators</i> and <i>azuredevops_team_members</i> resources. Therefore, it is not necessary to import the team to Terraform state.  

<b>>Import: Team & Git Repository</b>

If an import is necessary use the following code:

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

<b>Destroy deployment (terraform destroy)</b>

If the default repository and team have been imported to Terraform state, deleting a project via <i>terraform destroy</i> command will fail. This is also by design because the default repository/team resources cannot be deleted on their own but have to be deleted via the project resource. Remove the imported resources manually from Terraform state before executing the destroy-command to workaround this:  

<pre>
terraform state rm module.<i>&lt;team-module-name&gt;</i>.azuredevops_team.team
terraform state rm module.<i>&lt;git-repository-module-name&gt;</i>.azuredevops_git_repository.git_repository
</pre>

#### Outputs

The module currently generates the following outputs:  

1) <b>project</b> => list of all exported attribute values from the project resource  
2) <b>group_membership_project_administrators</b> => list of all exported attribute values from the group_membership.project_administrators resource  
3) <b>project_pipeline_settings</b> => list of all exported attribute values from the project_pipeline_settings resource  
4) <b>team</b> => list of all exported attribute values from the (project's default) team data source  
5) <b>git_repository</b> => list of all exported attribute values from the (project's default) git_repository data source  
6) <b>import_id_team</b> => output of a formatted id needed to import the team resource to Terraform state  
7) <b>import_id_git_repository</b> => output of a formatted id needed to import the git_resource resource to Terraform state  
  
### Module 'git_repository'

The module <i>git_repository</i> manages Azure DevOps project Git repositories.  

#### Known Issues Open Issues

n/a  

#### Outputs

The module currently generates the following outputs:  

1) <b>git_repository</b> => list of all exported attributes values from the git_repository resource  

### Module 'team'

> [!NOTE]
> The <b>team</b> module is released but has open issues.  

The module <i>team</i> manages Azure DevOps project teams.  
This includes the team itself as well as dependant repository resources (e.g. team administrators or team members).  

#### Known Issues / Open Issues

##### <i>azuredevops_team_administrators</i> and <i>azuredevops_team_members</i> show unnecessary changes in <i>terraform plan</i> mode
  
Running <i>terraform plan</i> command until running <i>terraform apply</i> always results in a plan output showing changes when managing teams. During plan mode Terraform is not able to recognize that the data source results for team_administrators and/or team_members are equal to the settings in the code.  
Running <i>terraform apply</i> does NOT process these changes because Terraform recognizes that no changes are necessary in apply mode.  
This also affects the default team_administrators resource in the project module.  

#### Outputs

The module currently generates the following outputs:  

1) <b>team</b> => list of all exported attributes values from the team resource  

### Module 'repository_policy'

> [!NOTE]
> The <b>repository_policy</b> module is under development but not released to public yet.  

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
> The <b>wiki</b> module is under development but not released to public yet and has open issues.  

The module <i>wiki</i> manages Azure DevOps wikis.  
This includes project wikis as well as code wikis.  

#### Known Issues / Open Issues

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
  
<i>Variable attribute 'state'</i>  
  
The module configures the 'state' attribute during initial apply. Then the attribute is ignored to avoid that state changes made by users are overwritten or reset by Terraform.  
  
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
 
### Azure DevOps users

As of 2024/11/12 the AzDO terraform provider has only a data source to get users' attribute values but no resource to create one without using entitlement resources. Therefore, to ensure that all modules are working as expected, all users that are used in the code must exist in the AzDO organisation before applying the modules' code. Otherwise the deployment fails.  
