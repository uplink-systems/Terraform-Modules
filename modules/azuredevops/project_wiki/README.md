## Module 'project_wiki'

> [!CAUTION]
> The <b>project_wiki</b> module has known issues that **can have** impact to module's functionality in some cases. Please read carefully!  

### Description and purpuse

The module <i>poroject_wiki</i> manages Azure DevOps wikis.  
This includes project wikis as well as code wikis. Because of the known issues mentioned below, 'codeWiki' is the module's default wiki type and creating a projectWiki must be specified explicitely.  

### Known Issues / Open Issues

#### Known: changing Wiki type

Changing the Wiki type from codeWiki to projectWiki and vice versa is not supported. While changing from codeWiki to projectWiki is working, the other way round is not.  

#### Known: destroying a Wiki

Destroying a Wiki of type codeWiki is supported and working. Destroying a Wiki of type projectWiki is not supported and not working. This is by design and cannot be worked around.  
  
> [!WARNING]
> Destroying the whole project via <i>terraform destroy</i> or by removing the resources from code is no longer working as soon as a Wiki of type projectWiki is created. This is caused by the known issue mentioned above. Therefore, use projectWiki with care!  

### Outputs

The module currently generates the following outputs:  

1) <b>wiki</b> => list of all exported attributes values from the wiki resource  
  
  
[Back to README.md](../README.md)  
