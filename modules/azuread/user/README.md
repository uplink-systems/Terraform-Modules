## Module Description

### Purpose

This module is intended to create Cloud-only user accounts in Azure AD with 'user_type' <b>Member</b>. The module manages user accounts and admin accounts and scopes all attributes available in the provider.  
  
<b>Please note that the module and its settings/results are build and optimized for Uplink Systems' internal requirements and conventions (e.g. users use the company's custom domain as UPN suffix whereas admins use the initial domain)! These settings have to be customized to your own needs.</b>  

### Example

For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuread/user 

### Versions

This module was tested with the following Terraform and provider versions before release:

<pre>
terraform {
  required_version = "= 1.9.6"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 3.0.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "= 2.5.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.6.3"
    }
  }
}
</pre>

Other version might work but are not tested by the module developer.

### Files

#### Credential files

The module exports each user's username and passwort as text file by default using 'local_file' resources (export can be prevented by setting <i>var.user.export.enabled</i> value to 'false'). Path and filename have defaule values but can be modified by configuring <i>var.user.export.path</i> and <i>var.user.export.file</i> (see section \"Variables / Locals\").  

### Variables / Locals

#### 'var.user.given_name'

The value for <i>var.user.given_name</i> is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'display_name', 'user_principal_name', 'mail' and 'mail_nickname' attributes. <i>local.given_name</i> transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.surname'

The value for <i>var.user.surname</i> is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'displayal_name'_name', 'user_princip, 'mail' and 'mail_nickname' attributes. <i>local.surname</i> transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.display_name'

The value for <i>var.user.display_name</i> is optional. The module has auto-build rules for default users' and admin users' <i>var.user.display_name</i> as <i>local.display_name</i> using the provided <i>var.user.surname</i>/<i>var.user.given_name</i> values (and appends a markup string for admins). 
Therefore, <i>var.user.display_name</i> must be specified only if the rule shall not apply.  

#### 'var.user.user_principal_name'

The value for <i>var.user.user_principal_name</i> is optional. The module has auto-build rules for default users' and admin users' <i>var.user.user_principal_name</i> as <i>local.user_principal_name</i> using the created <i>local.given_names</i>, <i>local.surname</i> and <i>local.domain_name</i> values (and prepends a markup string for admins). 
Therefore, <i>var.user.user_principal_name</i> must be specified only if the rule shall not apply.  

#### 'var.user.mail'

The value for <i>var.user.mail</i> is optional. The module has auto-build rules for default users' and admin users' <i>var.user.mail</i> as <i>local.mail</i> using the created <i>local.given_names</i>, <i>local.surname</i> and <i>local.domain_name</i> values (and prepends a markup string for admins). 
Therefore, <i>var.user.mail</i> must be specified only if the rule shall not apply.    

#### 'var.user.mail_nickname'

The value for <i>var.user.mail_nickname</i> is optional. The module has auto-build rules for default users' and admin users' <i>var.user.mail_nickname</i> as <i>local.mail_nickname</i> using the created <i>local.given_names</i>, <i>local.surname</i> and <i>local.domain_name</i> values (and prepends a markup string for admins). 
Therefore, <i>var.user.mail_nickname</i> must be specified only if the rule shall not apply.  

#### 'var.user.manager_id'

The value for <i>var.user.member_id</i> is optional and represents a user principal names for the user's manager. The module translates the user principal name to its corresponding object ID via data query.

#### 'var.user.sponsors'

The value for <i>var.user.sponsors</i> is optional and represents one or more user principal names for the account's sponsorship. Sponsorship is required only for admin accounts. The module translates the user principal names to their corresponding object ID via data query.  

###### NOTE

Setting/managing the sponsors attribute is not yet implemented in Terraform. Therefore, this option is for future releases (see 'Future implementations' below).

#### 'var.user.is_admin'

The value for <i>var.user.is_admin</i> (true/false) is used to force the use of admin-related values for some attributes:  

* 'random_string.password.length' --> force value '16' instead of default value '12'  
* 'azuread_user.user.disable_strong_password' -> force value 'false'  
* 'azuread_user.user.show_in_address_list' --> force value 'false'  
* 'azuread_user.user.manager_id' --> force value 'null'  
* 'local.domain_name' --> force 'initial' domain as domain suffix  
* ... and more ...  

#### 'var.user.export.enabled', 'var.user.export.path' and 'var.user.export.file'

The value of <i>var.user.export.enabled</i> specifies if the module exports the user's credentials to an output file (true) or not (false). The default value is 'true' if no other value is provided. The values for <i>var.user.export.path</i> and <i>var.user.export.file</i> represent the path and name of the credential export file to create. The module has a default value \"${path.root}/files/export/azuread/user\" for <i>var.user.export.path</i> and an auto-build rule for <i>var.user.export.file</i> using the created <i>local.given_names</i>, <i>local.surname</i> values.
Therefore, <i>var.user.export.enabled</i> must be specified only if credentials shall not be exported and <i>var.user.export.path</i> and/or <i>var.user.export.file</i> only if the value/rule shall not apply.  
  
<b>'var.user.export.path'</b>   
The value for <i>var.user.export.path</i> must be in Unix style (using forward slashes) even if Terraform is running on Windows.  
Examples for valid paths:  

<pre>
/terraform/files/output
./terraform/files/output
../terraform/files/output
C:/terraform/files/output
</pre>

### Outputs

The module currently generates the following outputs:  
1) <b>azuread_user</b> => list of all exported attributes values from all users  
2) <b>azuread_user_credential</b> => list of exported azruead_user.user_principal_name, random_string.password.result and local_file.azuread_user_credential[0].id attribute values as map from all users   
3) <b>azuread_user_credential_csv</b> => list of exported azruead_user.user_principal_name and random_string.password.result attribute values as comma-separated values from all users 


<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - UPNs of all users using 'azuread_user' output:  

<pre>
output "azuread_user_user_principal_name" {
  value       = values(module.azuread_user).*.azuread_user.user_principal_name
}
</pre>

Output - Credential details of all users using 'azuread_user_credential' output:

<pre>
output "azuread_user_credentials" {
  value       = values(module.azuread_user).*.azuread_user_credential
}
</pre>
</details>

### Known Issues

<details>
<summary><b>Passwords with 'random_string' resources</b></summary>

######
The module uses 'random_string' resources to generate the users' passwords instead of 'random_password'. Using 'random_string' is "easier" for a user mass deployment as this lets Terraform output the password in plain text instead of sensitive values like 'random_password' does.  
This should be changed for security reasons!  
######
</details>

<details>
<summary><b>Parental control attributes</b></summary>

######
The attributes 'parental_control.age_group' and 'parental_control.consent_provided_for_minor' can't be configured in one apply run. This is by design. The attribute 'parental_control.age_group' must be configured prior to 'parental_control.consent_provided_for_minor'.  
######
</details>

<details>
<summary><b>'sponsors'</b></summary>

######
The Azure AD attribute 'sponsors' is already available in Azure AD and can be set via Entra ID admin portal. The implementation in the Azure AD provider is currently still missing at the time of writing but may probably be available in a future version. <i>var.user.sponsors</i> and <i>data.azuread_user.sponsors</i> is already made available in the module but is not yet having any impacts.  

<pre>
#####  main.tf
resource "azuread_user" "user" {
  # sponsors - used for admins only
  sponsors              = var.user.is_admin == false ? null : (var.user.sponsors == null ? null : data.azuread_users.sponsors.object_ids)
}
</pre>
######
</details>

<details>
<summary><b>'certificate_user_ids'</b></summary>

######
The Azure AD attribute 'certificateUserIds' is already available in Azure AD and can be set via Entra ID admin portal. The implementation in the Azure AD provider is currently still missing at the time of writing but may probably be available in a future version.

<pre>
#####  variables.tf
  variable "user" {
    type = object({
      ...
      certificate_user_ids    = optional(list(string, []))
      ...
    })
  }
#####  local.tf
  locals {
    certificate_user_ids  = [ "X509:<PN>${local.user_principal_name}", "X509:<RFC822>${local.user_principal_name}" ]
  }
#####  main.tf
  resource "azuread_user" "user" {
    certificate_user_ids  = var.user.certificate_user_ids == null ? locals.certificate_user_ids : var.user.certificate_user_ids
  }
</pre>
######
</details>