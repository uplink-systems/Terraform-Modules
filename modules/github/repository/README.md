## Module 'repository'

### Description

This module is intended to create repositories in GitHub. Currently the module only creates the repository and configures the default branch. Further features are planned in future releases.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_github"></a> [integrations\/github](#requirement\_github) | ~> 6.0 |

### Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_branch_default.branch_default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository"></a> [user](#input\_repository) | 'var.repository' is the main variable for github_repository resource settings | <pre>tbd</pre> | none | yes |
| <a name="input_branch_default"></a> [user](#input\_branch\_default) | 'var.branch_default' is the optional variable for the github_branch_default resource settings | <pre>type        = object({<br>  branch      = string<br>})</pre> | none | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repository"></a> [github\_repository](#output\_github\_repository) | list of all exported attributes values from the repository resource(s) |
| <a name="output_github_branch_default"></a> [github\_branch\_default](#output\_github\_branch\_default) | list of all exported attributes values from the branch_default resource(s) |
  

### Known Issues

<details>
<summary><b>Repository for 'GitHub pages'</b></summary>

######
The module currently does not allow to create a repository for GitHub pages. This is planned in a future release.
######
</details>

<details>
<summary><b>Variable 'branch_default'</b></summary>

######
The variable 'branch_default' is unset (null) by default and if no other values are specified. In this case the 'main' branch is configured as default. Setting the variable to another branch can only be done after a repository has already been created, and after a correct reference has been created for the target branch inside the repository. This means a user will have to omit this parameter from the initial repository creation and create the target branch inside of the repository prior to setting this attribute.  
######
</details>
  
---
  
[Back to README.md](../README.md)  
