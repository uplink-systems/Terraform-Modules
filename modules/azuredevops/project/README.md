## Module 'project'

> [!NOTE]
> The <b>project</b> module has known issues **without** impact on the module's functionality. 

### Description and purpose

The module <i>project</i> manages Azure DevOps projects.  
This includes the project itself as well as some dependant project resources. E.g. the module can configure:  
1) <i>Project Administrators</i> group membership (user)
2) Default Team team-administrators (groups)
3) Project pipeline settings

> [!NOTE]
> A default repository and a default team are automatically generated when the project itself is created. The module contains two data sources to output the team- and repository-attributes from the module as well as two formatted outputs to use as import Ids. Furthermore, the module manages the administrators of the default team. If no administrator config is passed to the module, a default configuration applies adding the "Contributors" group as administrators.  
> For further info and why/how to make use of the output or not: see "Known Issues".  

### Known Issues / Open Issues

#### Known: <i>git_repository</i> and <i>team</i> resources created with a project by default
 
A new created project in Azure Devops automatically generates a repository labeled as <i>&lt;name of project&gt;</i> (if repository feature is enabled) and a default team labeled as <i>&lt;name of project&gt; Team</i>. This is by design and can't be suppressed.  
  
If the default resources should or need to be used, they can only be managed if they are imported. The 'project' module provides explicit outputs to use as import sources.  

> [!TIP]
> Default repository: It is best practice not to use the default repository and therefore, it is not necessary to import this resource to Terraform state. Instead, it is recommended to disable the repository manually.  
> Default team: The <i>azuredevops_team</i> resource can only manage the team's name, description, administrators and members. Name and description should not be changed for the defaul team. Administrators and members can be managed using <i>azuredevops_team_administrators</i> and <i>azuredevops_team_members</i> resources. Therefore, it is not necessary to import the team to Terraform state.  

<b>Import: Team & Git Repository</b>

If an import is necessary one can use the following code snippets:

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

### Outputs

The module currently generates the following outputs:  

1) <b>project</b> => list of all exported attribute values from the project resource  
2) <b>group_membership_project_administrators</b> => list of all exported attribute values from the group_membership.project_administrators resource  
3) <b>project_pipeline_settings</b> => list of all exported attribute values from the project_pipeline_settings resource  
4) <b>team</b> => list of all exported attribute values from the (project's default) team data source  
5) <b>git_repository</b> => list of all exported attribute values from the (project's default) git_repository data source  
6) <b>import_id_team</b> => output of a formatted id needed to import the team resource to Terraform state  
7) <b>import_id_git_repository</b> => output of a formatted id needed to import the git_resource resource to Terraform state  
  
  
[Back to README.md](../README.md)  
