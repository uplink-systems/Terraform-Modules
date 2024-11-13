# Terraform

### Terraform module collection

This repository is intended as a collection of simple Terraform modules.  

> [!INFO]
>I developed the modules primarily for my business purposes. That means that the modules are as complex as necessary and as simple as possible to match my business requirements and standards. Therefore, as many variables as possible have default (or even "non-variable") values e.g. to match my business internal naming conventions. That makes it easier for my business to follow standards and prevent the creation of non-standard resources.  
>I've seen a lot of complex modules out there with fantastic options. Respect to that but mine are not. They do what I want them to do. Nothing more, nothing less.  
>Keep that in mind when using them.  

### Notes

#### Module structure

The module structure tries to follow the recommended structure (https://developer.hashicorp.com/terraform/language/modules/develop/structure) with one additional folder layer for the type of infrastructure.