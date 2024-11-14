## Module 'project_git_repository'

### Description

The module <i>project_git_repository</i> manages Azure DevOps project Git repositories.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_git_repository.git_repository](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/git_repository) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_git_repository"></a> [git_repository](#input\_git\_repository) | git_repository main variable with resource attributes | <pre>object({<br>  name = string<br>  project_id = string<br>  default_branch = optional(string, "refs/heads/main")<br>  disabled = optional(bool, false)<br>  initialization = optional(object({<br>    init_type = optional(string, "Clean")<br>    source_type = optional(string, null)<br>    source_url = optional(string, null)<br>    service_connection_id = optional(string, null)<br>  }), {})<br>  parent_repository_id  = optional(string, null)<br>})</pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="ouput_git_repository"></a> [git_repository](#output\_git\_repository) | list of all exported attributes values from the git_repository resource |

### Known Issues

n/a  

---  
  
[Back to README.md](../README.md)  
