## README

### Description and purpose

These modules are intended to create and manage Azure DevOps resources related to projects following my business needs standards.  
This includes the following guidelines:  
* User Entitlements
  * Names of Azure DevOps related groups from connected Microsoft Entra directory used to onboard ADO users must start with "ADO-" to be processed.  
* Projects
  * Project names can only contain the following characters: 0-9, a-z, A-Z and -
  * Project are always named as one of (depending in which of Uplink Systems' AzDO organization the project is created):
    * EXT organization: Customer Number to which the repositories will be created for  
    * INT organization: <i>&lt;Project-Type&gt;</i>-<i>&lt;Project-Scope/Project-Purpose&gt;</i>, examples:  
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
  
Resources related to Azure DevOps organization settings are out ouf scope, except user onboarding.  

### Example

For an example how to use the modules please navigate to:  
https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuredevops  

### Modules

#### Module 'organization_user_entitlement'

[Module README](organization_user_entitlement/README.md)

#### Module 'project'

[Module README](project/README.md)

#### Module 'project_git_repository'

[Module README](project_git_repository/README.md)

#### Module 'project_repository_policy'

[Module README](project_repository_policy/README.md)

#### Module 'project_team'

[Module README](project_team/README.md)

#### Module 'project_wiki'

[Module README](project_wiki/README.md)

#### Module 'project_workitem'

[Module README](project_workitem/README.md)

### Known Issues

n/a  