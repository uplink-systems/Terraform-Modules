## README

### Purpose

These modules are intended to create and manage Azure DevOps resources related to projects following my business needs standards. Resources related to Azure DevOps organisation settings are out ouf scope.  

### Example

For an example how to use the modules please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuredevops  

### Modules

#### Module 'project'

The module <i>project</i> manages Azure DevOps projects.  
This includes the project itself as well as dependant project resources (e.g. project pipeline settings).  

> [!NOTE]
> A default team and a default repository are automatically generated when the project itself is created.  
> The module contains two data sources to output their attributes from the module as well as two formatted outputs to use as import Ids.  
> For further info and why/how to make use of the output: see "Known Issues".  

##### Open issues

n/a  

##### Outputs

The module currently generates the following outputs:  

1) <b>project</b> => list of all exported attributes values from the project resource  
2) <b>project_pipeline_settings</b> => list of all exported attributes values from the project_pipeline_settings resource  
3) <b>team</b> => list of all exported attributes values from the team data source  
4) <b>git_repository</b> => list of all exported attributes values from the git_repository data source  
5) <b>import_id_team</b> => output of a formatted id needed to import the team resource to Terraform state  
6) <b>import_id_git_repository</b> => output of a formatted id needed to import the git_resource resource to Terraform state  


#### Module 'git_repository'

The module <i>git_repository</i> manages Azure DevOps project Git repositories.  

##### Open issues

n/a  

##### Outputs

The module currently generates the following outputs:  

1) <b>git_repository</b> => list of all exported attributes values from the git_repository resource  

#### Module 'team'

> [!NOTE]
> The <b>'team'</b> module is not released/available yet.  

The module <i>team</i> manages Azure DevOps project teams.  
This includes the team itself as well as dependant repository resources (e.g. team administrators or team members).  

##### Open issues

Two data sources are currently required to differentiate between members and administrators. The goal is to only need one data source and to differentiate between the resources using a filtering method.  

<pre>
data "azuredevops_groups" "project_groups" {
  project_id      = var.team.project_id
  depends_on      = [ azuredevops_team.team ]
}
</pre>

##### Outputs

The module currently generates the following outputs:  

1) <b>team</b> => list of all exported attributes values from the team resource  

### Variables

n/a

### Known Issues
 
The modules are affected by the following known issues:  
 
#### AzDO resources created with a project by default
 
A new created project in Azure Devops automatically generates a repository labeled as <i>&lt;name of project&gt;</i> (if repository feature is enabled) and a default team labeled as <i>&lt;name of project&gt; Team</i>. This is by design and can't be suppressed.

> [!NOTE]
> It is best practice not to use these default resources and therefore, it is not necessary to import these resources to Terraform state. Instead, it is recommended to deactivate the repository and not use the team.  

If these resources should or need to be used anyway, they can only be managed if they are imported. The 'project' module provides explicit outputs to use as import sources.  

##### Import: Team & Git Repository

<pre>
import {
  id = "${module.<i>&lt;project module name&gt;</i>.import_id_team}"
  to = module.<i>&lt;team module name&gt;</i>.azuredevops_team.team
}
</pre>

<pre>
import {
  id = "${module.<i>&lt;project module name&gt;</i>.import_id_git_repository}"
  to = module.<i>&lt;git repository module name&gt;</i>.azuredevops_git_repository.git_repository
}
</pre>

> [!NOTE]
> Remove the 'import' blocks from code after importing the resources to Terraform state!

#### Destroy deployment (terraform destroy)

If the default repository and team have been imported to Terraform state, deleting a project via <i>terraform destroy</i> command will fail. This is also by design because the default repository/team resources cannot be deleted on their own but have to be deleted via the project resource. Remove the imported resources manually from Terraform state before executing the destroy-command to workaroung this:  

<pre>
terraform state rm module.<i>&lt;team module name&gt;</i>.azuredevops_team.team
terraform state rm module.<i>&lt;git repository module name&gt;</i>.azuredevops_git_repository.git_repository
</pre>