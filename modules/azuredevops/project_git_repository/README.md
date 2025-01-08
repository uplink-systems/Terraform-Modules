## Module 'project_git_repository'

### Description

The module <i>project_git_repository</i> manages Azure DevOps project Git repositories.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuredevops"></a> [microsoft\/azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_git_repository.git_repository](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/git_repository) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_git_repository"></a> [git\_repository](#input\_git\_repository) | git_repository main variable with resource attributes | <pre>type        = object({<br>  name                  = string<br>  project_id            = string<br>  default_branch        = optional(string, "refs/heads/main")<br>  disabled              = optional(bool, false)<br>  initialization        = optional(object({<br>    init_type             = optional(string, "Clean")<br>    source_type           = optional(string, null)<br>    source_url            = optional(string, null)<br>    service_connection_id = optional(string, null)<br>  }), {})<br>  parent_repository_id  = optional(string, null)<br>})</pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_git_repository"></a> [git\_repository](#output\_git\_repository) | list of all exported attributes values from the git_repository resource |

### Known Issues

<details>
<summary><b>Name of 'default branch' is not as expected</b></summary>

######
While in the past 'master' was often used as the default branch, today it is often 'main'. This is also reflected in AzDo, for example: the default branch name in the initially automatically generated project's repository is also 'main'. Unfortunately, the <i>git_repository</i> resource creates an old 'master' branch instead of a 'main' branch by default. In addition, the provider ignores the AzDo setting 'Default branch name for new repositories'. Even if this is enabled and the default branch name is set to 'main', a 'master' branch will be created instead. Since the default branch name in the module is 'refs/heads/main', an apply will fail if the variable is not explicitly passed with the 'refs/heads/master' default branch value.   
  
To work around this there are currently only 3 options, both of which are unfortunately unpleasant, because they need manual interaction and therefore contradict the idea of IaC deployment.  

<b>Option 1</b>  
The variable is configured as 'default_branch = "refs/heads/master"' when applying the code to create the repository. After that, a 'main' branch must be created manually in the Web UI. Then, in a further apply, the default branch variable can be removed from the code so that Terraform changes the default branch for the repository to the 'main' branch that now exists. Finally, the 'master' branch must be removed in the Web UI.  
  
<b>Option 2</b>  
The variable is configured as 'default_branch = "refs/heads/master"' when applying the code to create the repository. An additional code snipped must be added to the code, to create a 'main' branch during apply:
<pre>
resource "azuredevops_git_repository_branch" "main" {
  repository_id     = module.<i>{module-name}</i>.git_repository.repository.id
  name              = "main"
  ref_branch        = "master"
  depends_on        = [ module.<i>{module-name}</i> ]
}
</pre>
After the resources including the main branch have been created, it is deleted from the state file.  
<pre>terraform state rm [-dry-run] "azuredevops_git_repository_branch.main"</pre>
Finally, the snippet and the default_branch variable are removed from the code and an apply is executed again.  
  
<b>Option 3</b>  
The repository is created in the Web UI and imported afterwards. That at least enables to manage the repository after initial creation.  
  
</details>

---  
  
[Back to README.md](../README.md)  
