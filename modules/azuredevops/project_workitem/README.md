## Module 'project_workitem'

### Description  

The module **project_workitem** manages Azure DevOps project work items. This includes all types of work items for projects with all kinds of work item templates.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_workitem.workitem](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/workitem) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_workitem"></a> [workitem](#input\_workitem) | workitem main variable with resource attributes | <pre>type = object({<br>  title = string<br>  project_id = string<br>  type = string<br>  area_path = optional(string, null)<br>  custom_fields = optional(any)<br>  iteration_path = optional(string, null)<br>  state = optional(string, null)<br>  tags = optional(list(string), null)<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_workitem"></a> [workitem](#output\_workitem) | list of all exported attributes values from the workitem resource |

### Known Issues

n/a

### Other Notes

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
  
---
  
[Back to README.md](../README.md)  