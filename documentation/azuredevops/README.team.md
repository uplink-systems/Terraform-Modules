## Module 'team'

### Description and purpose

The module <i>team</i> manages Azure DevOps project teams.  
This includes the team itself as well as dependant repository resources (e.g. team administrators or team members).  

### Known Issues / Open Issues

> [!NOTE]
> The <b>team</b> module has known issues without impact on the module's functionality.  

#### <i>azuredevops_team_administrators</i> and <i>azuredevops_team_members</i> show unnecessary changes in <i>terraform plan</i> mode
  
Running <i>terraform plan</i> command until running <i>terraform apply</i> always results in a plan output showing changes when managing teams. During plan mode Terraform is not able to recognize that the data source results for team_administrators and/or team_members are equal to the settings in the code.  
Running <i>terraform apply</i> does NOT process these changes because Terraform recognizes that no changes are necessary in apply mode.  
This also affects the default team_administrators resource in the project module.  

### Outputs

The module currently generates the following outputs:  

1) <b>team</b> => list of all exported attributes values from the team resource  
  
  
[Back to README.md](../../modules/azuredevops/README.md)  