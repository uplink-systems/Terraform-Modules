## AzureRM_DNS

The <b>AzureAD_Group</b> modules are intended to manage Azure AD groups via Terraform Code.  
Authentication to Azure is done via client ID & client secret in this case but can be changed.

### Configurable Resources

The following resource types can be managed:

<pre>
-> Security groups with assigned membership
-> Security groups with dynamic membership
</pre>

The following resource types cannot be managed currently:

<pre>
-> Unified groups with assigned membership
-> Unified groups with dynamic membership
</pre>

### How it works

#### Files

Besides the default Terraform code snippets the module contains 2 files related to the <i>tbd</i> module in the <i>modules</i> subfolder.

##### resources.tf

The <code>resources.tf</code> file contains...  
1) ... the declaration of the variables <i>azuread_group_security_assigned</i> / <i>azuread_group_security_dynamic</i> and ...
2) ... the call of the modules <i>modules/azuread_group/security_assigned</i> / <i>modules/azuread_group/security_dynamic</i> using values of the <i>azuread_group_security_assigned</i> / <i>azuread_group_security_dynamic</i> variables.

##### resources.auto.tfvars

The <code>resources.auto.tfvars</code> file contains all values to use for the <i>azuread_group_security_assigned</i> / <i>azuread_group_security_dynamic</i> variables. See file content for exemplary values.
