## Module 'project_workitem'

### Description and purpose  

The module **project_workitem** manages Azure DevOps project work items. This includes all types of work items for projects with all kinds of work item templates.  

### Known Issues / Open Issues

n/a

### Outputs

The module currently generates the following outputs:  

1) <b>workitem</b> => list of all exported attributes values from the workitem resource  

### Remarkable notes

#### Variable attribute 'type'  
  
The valid and available values for the 'type' attribute depends on project's used work_item_template, e.g.:  
  
<pre>
Agile -> "Bug", "Epic", "Feature", "Issue", "Task", "Test Case", "User Story"
Basic -> "Epic", "Issue", "Task"
Scrum -> "Bug", "Epic", "Feature", "Impediment", "Product backlog item", "Task"
CMMI  -> "Bug", "Change Request", "Epic", "Feature", "Issue", "Requirment", "Review", "Risk", "Task"
</pre>
  
#### Variable attribute 'state'  
  
The module configures the 'state' attribute during initial apply. Then the attribute is ignored to avoid that state changes made by users are overwritten or reset by Terraform.  
  
#### Variable attribute 'custom_fields'  
  
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
  
  
[Back to README.md](../README.md)  