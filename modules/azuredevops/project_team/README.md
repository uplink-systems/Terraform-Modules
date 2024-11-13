## Module 'project_team'

> [!NOTE]
> The <b>project_team</b> module has known issues **without** impact on the module's functionality.

### Description and purpose

The module <i>project_team</i> manages Azure DevOps project teams.  
This includes the team itself as well as dependant repository resources (e.g. team administrators or team members).  

### Known Issues / Open Issues

#### <i>azuredevops_team_administrators</i> shows unnecessary changes in <i>terraform plan</i> mode
  
Running <i>terraform plan</i> command until running <i>terraform apply</i> always results in a plan output showing changes when managing teams. During plan mode Terraform is not able to recognize that the data source results for team_administrators are equal to the settings in the code.  
Running <i>terraform apply</i> does NOT process these changes because Terraform recognizes that no changes are necessary in apply mode.  
This also affects the default team_administrators resource in the project module.  

#### <i>azuredevops_team_members</i> shows unnecessary changes in <i>terraform plan</i> mode
  
Running <i>terraform plan</i> command until running <i>terraform apply</i> always results in a plan output showing changes when managing teams. During plan mode Terraform is not able to recognize that the data source results for team_members are equal to the settings in the code.  
Running <i>terraform apply</i> does NOT process these changes because Terraform recognizes that no changes are necessary in apply mode.  

### Outputs

The module currently generates the following outputs:  

1) <b>team</b> => list of all exported attributes values from the team resource  
  
  
[Back to README.md](../README.md)  