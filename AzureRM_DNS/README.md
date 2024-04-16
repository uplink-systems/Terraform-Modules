## AzureRM_DNS

The 'AzureRM_DNS' module is intended to manage a DNS zone and its records via Terraform Code.  
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

The following recordsets cannot be managed:

<pre>
--> NS recordsets (root recordset)
--> SOA recordsets
</pre>

### How it works

#### Files

Besides the default Terraform code snippets the module contains 2 files related to the 'azure_dns' module in the 'modules' subfolder.

##### resources.tf

The resources.tf file contains...  
1) ... the declaration of the variable 'azure_dns' and ...
2) ... the call of the module 'azure_dns' using values of the 'azure_dns' variable.

##### resources.auto.tfvars

The resources.auto.tfvars file contains all values to use for the 'azure_dns' variable. See file content for exemplary values.
