## AzureRM_DNS

The <b>AzureRM_DNS</b> module is intended to manage a DNS zone and its records via Terraform Code.  
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

Besides the default Terraform code snippets the module contains 2 files related to the <i>azurerm_dns</i> module in the <i>modules</i> subfolder.

##### resources.tf

The <code>resources.tf</code> file contains...  
1) ... the declaration of the variable <i>azurerm_dns</i> and ...
2) ... the call of the module <i>modules/azurerm_dns</i> using values of the <i>azurerm_dns</i> variable.

##### resources.auto.tfvars

The <code>resources.auto.tfvars</code> file contains all values to use for the <i>azurerm_dns</i> variable. See file content for exemplary values.
