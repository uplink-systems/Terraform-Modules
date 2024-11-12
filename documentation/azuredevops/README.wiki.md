## Module 'wiki'

> [!NOTE]
> The <b>wiki</b> module has known issues that can have impact to module's functionality in some cases. Please read carefully!  

### Description and purpuse

The module <i>wiki</i> manages Azure DevOps wikis.  
This includes project wikis as well as code wikis. Because of the known issues mentioned below, 'codeWiki' is the module's default wiki type and creating a projectWiki must be specified explicitely.  

### Known Issues / Open Issues

#### Changing Wiki type

Changing the Wiki type from codeWiki to projectWiki and vice versa is not supported. While changing from codeWiki to projectWiki is working, the other way round is not.  

#### Destroying a Wiki

Destroying a Wiki of type codeWiki is supported and working. Destroying a Wiki of type projectWiki is not supported and not working. This by design and cannot be worked around.  
  
> [!CAUTION]
> Destroying the whole project via <i>terraform destroy</i> or by removing the resources from code is no longer working as soon as a Wiki of type projectWiki is created. This is caused by the known issue mentioned above. Therefore, use projectWiki with care!  

### Outputs

The module currently generates the following outputs:  

1) <b>wiki</b> => list of all exported attributes values from the wiki resource  
  
  
[Back to README.md](../../modules/azuredevops/README.md)  