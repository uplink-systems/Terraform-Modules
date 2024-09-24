
# EXAMPLES

#### Files

By default, each example the following files:

<pre>
-> main.tf
-> main.auto.tfvars
-> provider.tf
-> variables.tf
-> versions.tf
</pre>

Additional files can exist and are example-specific.

# MODULES

## AzureAD_Group

The <b>AzureAD_Group</b> modules are intended to manage Azure AD groups via Terraform Code.  
Authentication to Azure is done via client ID & client secret in this case but can be changed.

### Configurable Resources

The following resource types can be managed:

<pre>
-> Security groups with assigned membership
-> Security groups with dynamic membership
</pre>

The following resource types cannot be managed currently (implementation planned):

<pre>
-> Unified groups with assigned membership
-> Unified groups with dynamic membership
</pre>

### How it works

#### Files

## AzureAD Named Location

The <b>AzureAD Named Location</b> modules are intended to manage Azure AD named locations via Terraform Code.  
Authentication to Azure is done via client ID & client secret in this case but can be changed.

### Configurable Resources

The following resource types can be managed:

<pre>
-> Country/Geolocation based named locations (module: azuread/named_location/country)
-> IP/Range based named locations (module: azuread/named_location/ip)
</pre>

The following resource types cannot be managed currently:

<pre>
-> n/a
</pre>

### How it works

#### Files

## AzureRM DNS

The <b>AzureRM DNS</b> module is intended to manage a DNS zone and its records via Terraform Code.  
Authentication to Azure is done via client ID & client secret in this case but can be changed.

### Configurable Resources

Due to API limitations not all types of DNS-related resources can be managed.  
The following resource types can be managed:

<pre>
-> DNS zone
--> A recordsets
--> AAA recordsets
--> CAA recordsets
--> CNAME recordsets
--> MX recordsets
--> NS recordsets (non-root recordsets)
--> SRV recordsets
--> TXT recordsets
</pre>

The following resource types cannot be managed:

<pre>
--> NS recordsets (root recordset)
--> SOA recordsets
</pre>

### How it works

#### Files

