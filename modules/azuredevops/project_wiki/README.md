## Module 'project_wiki'

> [!CAUTION]
> The **project_wiki** module has known issues that **can have** impact to module's functionality in some cases. Please read carefully!  

### Description

The module **poroject_wiki** manages Azure DevOps wikis. This includes project wikis as well as code wikis. Because of the known issues mentioned below, *codeWiki* is the module's default wiki type and creating a *projectWiki* must be specified explicitely.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuredevops"></a> [microsoft\/azuredevops](#requirement\_azuredevops) | ~> 1.4 |

### Resources

| Name | Type |
|------|------|
| [azuredevops_wiki.wiki](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/wiki) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_wiki"></a> [wiki](#input\_wiki) | wiki main variable with resource attributes | <pre>type = object({<br>  name = string<br>  project_id = string<br>  mapped_path = optional(string, "/")<br>  repository_id = optional(string, null)<br>  type = optional(string, "codeWiki")<br>  version = optional(string, "main")<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_wiki"></a> [wiki](#output\_wiki) | list of all exported attributes values from the wiki resource |

### Known Issues

<details>
<summary><b>Changing Wiki type</b></summary>

######
Changing the Wiki type from codeWiki to projectWiki and vice versa is not supported. While changing from codeWiki to projectWiki is working, the other way round is not.  
######
</details>

<details>
<summary><b>Removing a Wiki</b></summary>

######
Removing/destroying a Wiki of type *codeWiki* is supported and working. Removing/destroying a Wiki of type *projectWiki* is not supported and not working. This is by design and cannot be worked around.  
Removing/destroying the whole project via *terraform destroy* or by removing the resources from code is no longer working as soon as a Wiki of type *projectWiki* is created. This is caused by the known issue mentioned above. Therefore, use *projectWiki* with care!  
######
</details>
  
---
  
[Back to README.md](../README.md)  
