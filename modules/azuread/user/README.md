## Module 'user'

### Description

This module is intended to create Cloud-only user accounts in Azure AD with 'user_type' **Member*. The module manages user accounts and admin accounts and scopes all attributes available in the provider. It is designed to handle multiple users or even all users using for_each loop in the root module.  
  
**Please note that the module and its settings/results are build and optimized for Uplink Systems' internal requirements and conventions (e.g. users use the company's custom domain as UPN suffix whereas admins use the initial domain)! These settings have to be customized to your own needs.**  

For an example how to use this module please navigate to: https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuread/user 

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0 |

### Files

#### Credential files

The module exports each user's username and passwort as text file by default using 'local_file' resources (export can be prevented by setting *var.user.export.enabled* value to 'false'). Path and filename have defaule values but can be modified by configuring *var.user.export.path* and *var.user.export.file* (see section \"Variables / Locals\").  

### Variables / Locals

#### 'var.user.given_name'

The value for *var.user.given_name* is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'display_name', 'user_principal_name', 'mail' and 'mail_nickname' attributes. *local.given_name* transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.surname'

The value for *var.user.surname* is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'displayal_name'_name', 'user_princip, 'mail' and 'mail_nickname' attributes. *local.surname* transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.display_name'

The value for *var.user.display_name* is optional. The module has auto-build rules for default users' and admin users' *var.user.display_name* as *local.display_name* using the provided *var.user.surname*/*var.user.given_name* values (and appends a markup string for admins). 
Therefore, *var.user.display_name* must be specified only if the rule shall not apply.  

#### 'var.user.user_principal_name'

The value for *var.user.user_principal_name* is optional. The module has auto-build rules for default users' and admin users' *var.user.user_principal_name* as *local.user_principal_name* using the created *local.given_names*, *local.surname* and *local.domain_name* values (and prepends a markup string for admins). 
Therefore, *var.user.user_principal_name* must be specified only if the rule shall not apply.  

#### 'var.user.mail'

The value for *var.user.mail* is optional. The module has auto-build rules for default users' and admin users' *var.user.mail* as *local.mail* using the created *local.given_names*, *local.surname* and *local.domain_name* values (and prepends a markup string for admins). 
Therefore, *var.user.mail* must be specified only if the rule shall not apply.    

#### 'var.user.mail_nickname'

The value for *var.user.mail_nickname* is optional. The module has auto-build rules for default users' and admin users' *var.user.mail_nickname* as *local.mail_nickname* using the created *local.given_names*, *local.surname* and *local.domain_name* values (and prepends a markup string for admins). 
Therefore, *var.user.mail_nickname* must be specified only if the rule shall not apply.  

#### 'var.user.manager_id'

The value for *var.user.member_id* is optional and represents a user principal names for the user's manager. The module translates the user principal name to its corresponding object ID via data query.

#### 'var.user.sponsors'

The value for *var.user.sponsors* is optional and represents one or more user principal names for the account's sponsorship. Sponsorship is required only for admin accounts. The module translates the user principal names to their corresponding object ID via data query.  

###### NOTE

Setting/managing the sponsors attribute is not yet implemented in Terraform. Therefore, this option is for future releases (see 'Future implementations' below).

#### 'var.user.is_admin'

The value for *var.user.is_admin* (true/false) is used to force the use of admin-related values for some attributes:  

* 'random_string.password.length' --> force value '16' instead of default value '12'  
* 'azuread_user.user.disable_strong_password' -> force value 'false'  
* 'azuread_user.user.show_in_address_list' --> force value 'false'  
* 'azuread_user.user.manager_id' --> force value 'null'  
* 'local.domain_name' --> force 'initial' domain as domain suffix  
* ... and more ...  

#### 'var.user.export.enabled', 'var.user.export.path' and 'var.user.export.file'

The value of *var.user.export.enabled* specifies if the module exports the user's credentials to an output file (true) or not (false). The default value is 'true' if no other value is provided. The values for *var.user.export.path* and *var.user.export.file* represent the path and name of the credential export file to create. The module has a default value \"${path.root}/files/export/azuread/user\" for *var.user.export.path* and an auto-build rule for *var.user.export.file* using the created *local.given_names*, *local.surname* values.
Therefore, *var.user.export.enabled* must be specified only if credentials shall not be exported and *var.user.export.path* and/or *var.user.export.file* only if the value/rule shall not apply.  
  
<b>'var.user.export.path'</b>   
The value for *var.user.export.path* must be in Unix style (using forward slashes) even if Terraform is running on Windows.  
Examples for valid paths:  

<pre>
/terraform/files/output
./terraform/files/output
../terraform/files/output
C:/terraform/files/output
</pre>

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_user"></a> [user](#input\_user) | 'var.user' is the main variable for azuread_user resource settings | <pre>type = object({<br>  given_name                  = string<br>  surname                     = string<br>  display_name                = optional(string, null)<br>  user_principal_name         = optional(string, null)<br>  account_enabled             = optional(bool, true)<br>  force_password_change       = optional(bool, true)<br>  disable_password_expiration = optional(bool, false)<br>  disable_strong_password     = optional(bool, false)<br>  is_admin                    = optional(bool, false)<br>  preferred_language          = optional(string, "en-US")<br>  usage_location              = optional(string, null)<br>  mail_nickname               = optional(string, null)<br>  mail                        = optional(string, null)<br>  other_mails                 = optional(list(string), [])<br>  show_in_address_list        = optional(bool, true)<br>  employee_id                 = optional(string, null)<br>  employee_type               = optional(string, null)<br>  job_title                   = optional(string, null)<br>  company_name                = optional(string, null)<br>  division                    = optional(string, null)<br>  department                  = optional(string, null)<br>  cost_center                 = optional(string, null)<br>  manager_id                  = optional(string, null)<br>  sponsors                    = optional(list(string), [])<br>  country                     = optional(string, null)<br>  state                       = optional(string, null)<br>  postal_code                 = optional(string, null)<br>  city                        = optional(string, null)<br>  street_address              = optional(string, null)<br>  office_location             = optional(string, null)<br>  business_phones             = optional(list(string), [])<br>  mobile_phone                = optional(string, null)<br>  fax_number                  = optional(string, null)<br>  parental_control            = optional(object({<br>    enabled                     = optional(bool, true)<br>    age_group                   = optional(string, null)<br>    consent_provided_for_minor  = optional(string, null)<br>  }), { enabled = false })<br>  export[^1]                    = optional(object({<br>    enabled                     = optional(bool, true)<br>    file                        = optional(string, null)<br>    path                        = optional(string, null)<br>  }), { enabled = true })<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azuread_user"></a> [azuread\_user](#output\_azuread\_user) | list of all exported attributes values from from all users |
| <a name="output_azuread_user_credential"></a> [azuread\_user\_credential](#output\_azuread\_user\_credential) | list of exported azruead_user.user_principal_name, random_string.password.result and local_file.azuread_user_credential[0].id attribute values as map from all users |
| <a name="output_azuread_user_credential_csv"></a> [azuread\_user\_credential\_csv](#output\_azuread\_user\_credential\_csv) | list of exported azruead_user.user_principal_name and random_string.password.result attribute values as comma-separated values from all users |

<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - UPNs of all users using 'azuread_user' output:  

<pre>
output "azuread_user_user_principal_name" {
  value   = values(module.azuread_user).*.azuread_user.user_principal_name
}
</pre>

Output - Credential details of all users using 'azuread_user_credential' output:

<pre>
output "azuread_user_credentials" {
  value   = values(module.azuread_user).*.azuread_user_credential
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
<summary><b>(Optional) possible prospective attribute/feature: 'sponsors'</b></summary>

######
The Azure AD attribute 'sponsors' is already available in Azure AD and can be set via Entra admin portal. The implementation in the Azure AD provider is currently still missing at the time of writing but may probably be available in a future version. *var.user.sponsors* and *data.azuread_user.sponsors* is already made available in the module but is not yet having any impacts until this feature becomes available.  

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
<summary><b>(Optional) possible prospective attribute/feature: 'certificate_user_ids'</b></summary>

######
The Azure AD attribute 'certificateUserIds' is already available in Azure AD and can be set via Entra admin portal. The implementation in the Azure AD provider is currently still missing at the time of writing but may probably be available in a future version.

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




## Footnotes

[^9]:
#### 'var.user.is_admin'

The value for *var.user.is_admin* (true/false) is used to force the use of admin-related values for some attributes:  

* 'random_string.password.length' --> force value '16' instead of default value '12'  
* 'azuread_user.user.disable_strong_password' -> force value 'false'  
* 'azuread_user.user.show_in_address_list' --> force value 'false'  
* 'azuread_user.user.manager_id' --> force value 'null'  
* 'local.domain_name' --> force 'initial' domain as domain suffix  
* ... and more ...  

[^1]: <b>'var.user.export'</b>: 
  The value of *var.user.export.enabled* specifies if the module exports the user's credentials to an output file (true) or not (false). The default value is 'true' if no other value is provided. The values for *var.user.export.path* and *var.user.export.file* represent the path and name of the credential export file to create. The module has a default value \"${path.root}/files/export/azuread/user\" for *var.user.export.path* and an auto-build rule for *var.user.export.file* using the created *local.given_names*, *local.surname* values.
  Therefore, *var.user.export.enabled* must be specified only if credentials shall not be exported and *var.user.export.path* and/or *var.user.export.file* only if the value/rule shall not apply.  
  <b>'var.user.export.path'</b>   
  The value for *var.user.export.path* must be in Unix style (using forward slashes) even if Terraform is running on Windows.  
  Examples for valid paths:  
   <pre>
  /terraform/files/output
  ./terraform/files/output
  ../terraform/files/output
  C:/terraform/files/output
  </pre>