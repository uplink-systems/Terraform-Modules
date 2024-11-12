## README

### Description and purpose

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

### Example

For an example how to use the modules please navigate to:  
https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuredevops  

### Modules

#### Module 'project'

[Module Documentation README](../../documentation/azuredevops/README.project.md)

#### Module 'git_repository'

[Module Documentation README](../../documentation/azuredevops/README.git_repository.md)

#### Module 'repository_policy'

[Module Documentation README](../../documentation/azuredevops/README.repository_policy.md)

#### Module 'team'

[Module Documentation README](../../documentation/azuredevops/README.team.md)

#### Module 'wiki'

[Module Documentation README](../../documentation/azuredevops/README.wiki.md)

#### Module 'workitem'

[Module Documentation README](../../documentation/azuredevops/README.workitem.md)

### Known Issues

#### Azure DevOps users

As of 2024/11/12 the AzDO terraform provider has only a data source to get users' attribute values but no resource to create one without using entitlement resources. Therefore, to ensure that all modules are working as expected, all users that are used in the code must exist in the AzDO organisation before applying the modules' code. Otherwise the deployment fails.  
