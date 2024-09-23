## AzureAD_Named_Location

The <b>AzureAD_Named_Location</b> modules are intended to manage Azure AD named locations via Terraform Code.  
Authentication to Azure is done via client ID & client secret in this case but can be changed.

### Configurable Resources

The following resource types can be managed:

<pre>
-> Geolocation based named locations
-> IP based named locations
</pre>

The following resource types cannot be managed currently:

<pre>
-> n/a
</pre>

### How it works

#### Files

Besides the default Terraform code snippets the module contains 2 files related to the <i>azuread_named_location_country</i> / <i>azuread_named_location_ip</i> modules in the <i>modules</i> subfolder.

##### resources.tf

The <code>resources.tf</code> file contains...  
1) ... the declaration of the variables <i>azuread_named_location_country</i> / <i>azuread_named_location_ip</i> and ...
2) ... the call of the modules in folder <i>modules/azuread_named_location_country</i> / <i>modules/azuread_named_location_ipc</i> using values of the <i>azuread_named_location_country</i> / <i>azuread_named_location_ip</i> variables.

##### resources.auto.tfvars

The <code>resources.auto.tfvars</code> file contains all values to use for the <i>azuread_named_location_country</i> / <i>azuread_named_location_ip</i> variables. See file content for exemplary values.
