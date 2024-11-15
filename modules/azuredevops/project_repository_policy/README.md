## Module 'project_repository_policy'

### Description

The module **project_repository_policy** manages Azure DevOps project and/or repository policies. Its primary purpose is to create the policies on project-level but has the option to configure repository-level policies to differ from project default.   

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuredevops"></a> [microsoft\/azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_repository_policy_author_email_pattern.author_email_pattern](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_author_email_pattern) | resource |
| [azuredevops_repository_policy_case_enforcement.case_enforcement](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_case_enforcement) | resource |
| [azuredevops_repository_policy_check_credentials.check_credentials](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_check_credentials) | resource |
| [azuredevops_repository_policy_file_path_pattern.file_path_pattern](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_file_path_pattern) | resource |
| [azuredevops_repository_policy_max_file_size.max_file_size](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_max_file_size) | resource |
| [azuredevops_repository_policy_max_path_length.max_path_length](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_max_path_length) | resource |
| [azuredevops_repository_policy_reserved_names.reserved_names](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/repository_policy_reserved_names) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository_policy"></a> [repository\_policy](#input\_repository\_policy) | repository policy attributes to process | <pre>type        = object({<br>  project_id            = string<br>  repository_ids        = optional(list(string), null)<br>  author_email_pattern  = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>    author_email_patterns   = list(string)<br>  }), {<br>    enabled                 = false<br>    author_email_patterns   = ["\*@example.code"]<br>  })<br>  case_enforcment       = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>    enforce_consistent_case = optional(bool, true)<br>  }), {<br>    enabled                 = false<br>    enforce_consistent_case = false<br>  })<br>  file_path_pattern     = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>    file_path_patterns      = list(string)<br>  }), {<br>    enabled                 = false<br>  check_credentials     = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>  }), { enabled = false })<br>    file_path_patterns      = ["example.code","/code/\*.example"]<br>  })<br>  max_file_size         = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>    max_file_size           = optional(number, 10)<br>  }), { enabled = false })<br>  max_path_length       = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>    max_path_length         = optional(number, 1000)<br>  }), { enabled = false })<br>  reserved_names        = optional(object({<br>    enabled                 = optional(bool, true)<br>    blocking                = optional(bool, true)<br>  }), { enabled = false })<br>})</pre> | n/a | yes |


type        = object({
project_id            = string
repository_ids        = optional(list(string), null)
author_email_pattern  = optional(object({
    enabled                 = optional(bool, true)
    blocking                = optional(bool, true)
    author_email_patterns   = list(string)
}), {
    enabled                 = false
    author_email_patterns   = ["*@example.code"]
})
case_enforcment       = optional(object({
    enabled                 = optional(bool, true)
    blocking                = optional(bool, true)
    enforce_consistent_case = optional(bool, true)
}), {
    enabled                 = false
    enforce_consistent_case = false
})

file_path_pattern     = optional(object({
    enabled                 = optional(bool, true)
    blocking                = optional(bool, true)
    file_path_patterns      = list(string)
}), {
    enabled                 = false
    file_path_patterns      = ["example.code","/code/*.example"]
})
max_file_size         = optional(object({
    enabled                 = optional(bool, true)
    blocking                = optional(bool, true)
    max_file_size           = optional(number, 10)
}), { enabled = false })
max_path_length       = optional(object({
    enabled                 = optional(bool, true)
    blocking                = optional(bool, true)
    max_path_length         = optional(number, 1000)
}), { enabled = false })
reserved_names        = optional(object({
    enabled                 = optional(bool, true)
    blocking                = optional(bool, true)
}), { enabled = false })
})



### Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_policy_author_email_pattern"></a> [repository\_policy\_author\_email\_pattern](#output\_repository\_policy\_author\_email\_pattern) | list of all exported attributes values from the repository_policy_author_email_pattern resource |
| <a name="output_repository_policy_case_enforcement"></a> [repository\_policy\_case\_enforcement](#output\_repository\_policy\_case\_enforcement) | list of all exported attributes values from the repository_policy_case_enforcement resource |
| <a name="output_repository_policy_check_credentials"></a> [repository\_policy\_check\_credentials](#output\_repository\_policy\_check\_credentials) | list of all exported attributes values from the repository_policy_check_credentials resource |
| <a name="output_repository_policy_file_path_pattern"></a> [repository\_policy\_file\_path\_pattern](#output\_repository\_policy\_file\_path\_pattern) | list of all exported attributes values from the repository_policy_file_path_pattern resource |
| <a name="output_repository_policy_max_file_size"></a> [repository\_policy\_max\_file\_size](#output\_repository\_policy\_max\_file\_size) | list of all exported attributes values from the repository_policy_max_file_size resource |
| <a name="output_repository_policy_max_path_length"></a> [repository\_policy\_max\_path\_length](#output\_repository\_policy\_max\_path\_length) | list of all exported attributes values from the repository_policy_max_path_length resource |
| <a name="output_repository_policy_reserved_names"></a> [repository\_policy\_reserved\_names](#output\_repository\_policy\_reserved\_names) | list of all exported attributes values from the repository_policy_reserved_names resource |

### Known Issues

<details>
<summary><b>n/a</b></summary>

######
  
</details>

---  
  
[Back to README.md](../README.md)  