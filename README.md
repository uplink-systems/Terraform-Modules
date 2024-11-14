# Terraform

### Terraform module collection

This repository is intended as a collection of simple Terraform modules.  

> [!IMPORTANT]
>I developed the modules primarily with the organization's business needs in mind. That means that the modules are as complex as necessary and as simple as possible to match the organization's business requirements and standards. Therefore, as many variable attributes as possible have default values or are even configured as static e.g. to match the business' internal naming conventions. That makes it easier for the organization's business to follow standards and prevent the creation of non-standard resources.  
>I've seen a lot of complex modules out there with really fantastic options. Respect for that but mine are not like that. They are as simple as possible and do what I want them to do. Nothing more, nothing less.  
>  
>**Keep that in mind when using them.**  

### Notes

#### Module structure

The module structure tries to follow the recommended structure except that I use one additional folder layer for the type of infrastructure to manage.  
For more information see: https://developer.hashicorp.com/terraform/language/modules/develop/structure  