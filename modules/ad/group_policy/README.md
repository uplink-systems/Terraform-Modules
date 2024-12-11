## Module 'group_policy'

### Description

This module is intended to create and manage a Group Policy object in an local AD. Optionally the Group Policy object can be linked to one or more Organisational Units and security settings can be configured within the Group Policy object. 
  
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ad"></a> [hashicorp\/ad](#requirement\_azuread) | ~> 0.5 |

### Resources

| Name | Type |
|------|------|
| [ad_gpo.gpo](https://registry.terraform.io/providers/hashicorp/ad/latest/docs/resources/gpo) | resource |
| [ad_gplink.gplink](https://registry.terraform.io/providers/hashicorp/ad/latest/docs/resources/gplink) | resource |
| [ad_gpo_security.gpo_security](https://registry.terraform.io/providers/hashicorp/ad/latest/docs/resources/gpo_security) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gpo"></a> [gpo](#input\_gpo) | 'var.gpo' is the main variable for ad_gpo resource settings | <pre>type        = object({<br>  name        = string<br>  description = optional(string, null)<br>  domain      = optional(string, null)<br>  status      = optional(string, null)<br>})<br></pre> | n/a | yes |
| <a name="input_gplink"></a> [gplink](#input\_gplink) | 'var.gplink' is the (optional) main variable for ad_gplink resource settings | <pre>type = map(object({<br>  target_dn   = string<br>  enforced    = optional(bool, false)<br>  enabled     = optional(bool, true)<br>}))<br></pre> | {} | no |
| <a name="input_gpo_security"></a> [gpo_security](#input\_gpo_security) | 'var.gpo_security' is the (optional) main variable for ad_gpo_security resource settings | <pre>type        = object({<br>  enabled            = optional(bool, true)<br>  account_lockout    = optional(object({<br>    force_logoff_when_hour_expire = optional(string, null)<br>    lockout_bad_count             = optional(string, null)<br>    lockout_duration              = optional(string, null)<br>    reset_lockout_count           = optional(string, null)<br>  }))<br>  application_log     = optional(object({<br>    audit_log_retention_period    = optional(string, null)<br>    maximum_log_size              = optional(string, null)<br>    restrict_guest_access         = optional(string, null)<br>    retention_days                = optional(string, null)<br>  }))<br>  audit_log           = optional(object({<br>    audit_log_retention_period    = optional(string, null)<br>    maximum_log_size              = optional(string, null)<br>    restrict_guest_access         = optional(string, null)<br>    retention_days                = optional(string, null)<br>  }))<br>  event_audit         = optional(object({<br>    audit_account_logon           = optional(string, null)<br>    audit_account_manage          = optional(string, null)<br>    audit_ds_access               = optional(string, null)<br>    audit_logon_events            = optional(string, null)<br>    audit_object_access           = optional(string, null)<br>    audit_policy_change           = optional(string, null)<br>    audit_privilege_use           = optional(string, null)<br>    audit_process_tracking        = optional(string, null)<br>    audit_system_events           = optional(string, null)<br>  }))<br>  filesystem          = optional(list(object({<br>    path                          = string<br>    acl                           = string<br>    propagation_mode              = optional(string, "0")<br>  })))<br>  kerberos_policy     = optional(object({<br>    max_clock_skew                = optional(string, null)<br>    max_renew_age                 = optional(string, null)<br>    max_service_age               = optional(string, null)<br>    max_ticket_age                = optional(string, null)<br>    ticket_validate_client        = optional(string, null)<br>  }))<br>  password_policies   = optional(object({<br>    clear_text_password           = optional(string, null)<br>    maximum_password_age          = optional(string, null)<br>    minimum_password_age          = optional(string, null)<br>    minimum_password_length       = optional(string, null)<br>    password_complexity           = optional(string, null)<br>    password_history_size         = optional(string, null)<br>  }))<br>  registry_keys       = optional(list(object({<br>    key_name                      = string<br>    acl                           = string<br>    propagation_mode              = optional(string, "0")<br>  })))<br>  registry_values     = optional(list(object({<br>    key_name                      = string<br>    value                         = string<br>    value_type                    = optional(string, "1")<br>  })))<br>  restricted_groups   = optional(list(object({<br>    group_name                    = string<br>    group_memberof                = optional(string, "")<br>    group_members                 = optional(string, "")<br>  })))<br>  system_log         = optional(object({<br>    audit_log_retention_period    = optional(string, null)<br>    maximum_log_size              = optional(string, null)<br>    restrict_guest_access         = optional(string, null)<br>    retention_days                = optional(string, null)<br>  }))<br>  system_services     = optional(list(object({<br>    service_name                  = string<br>    startup_mode                  = optional(string, "2")<br>    acl                           = optional(string, "")<br>  })))<br>})<br></pre> | { enabled = false } | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ad_gpo"></a> [ad\_gpo](#output\_ad\_gpo) | list of all exported attributes values from the gpo resourc |
| <a name="output_ad_gplink"></a> [ad\_gplink](#output\_ad\_gplink) | list of all exported attributes values from the gplink resource(s) |
| <a name="output_ad_gpo_security"></a> [ad\_gpo\_security](#output\_ad\_gpo\_security) | list of all exported attributes values from the gpo_security resource |


<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - all attributes of the 'ad_gpo' output:  

```
output "ad_gpo" {
  value   = module.ad_gpo.ad_gpo
}
```
</details>
  
## Notes

### Variables / Locals

#### 'var.gpo'

The variable *var.gpo* consists of attributes that have only a select list of accepted values.  
- *var.gpo.status* (values are case sensitive)
  - AllSettingsEnabled
  - UserSettingsDisabled
  - ComputerSettingsDisabled
  - AllSettingsDisabled

#### 'var.gpo_security'

The variable *var.gpo_security* consists of attributes that have only a select list of accepted values.  
- *var.gpo_security.application_log.audit_log_retention_period*
  - 0 = overwrite events as needed
  - 1 = overwrite events as specified specified by *var.gpo_security.application_log.retention_days*
  - 2 = never overwrite events.
- *var.gpo_security.application_log.maximum_log_size*
  - 64 - 4194240 KB
- *var.gpo_security.application_log.retention_days*
  - 1 - 365 days
- *var.gpo_security.application_log.audit_<*>*
  - 0 = None
  - 1 = Success audits only
  - 2 = Failure audits only
  - 3 = Success and failure audits
  - 4 = None
- *var.gpo_security.filesystem.propagation_mode*
  - 0 = Propagate permissions to all subfolders and files
  - 1 = Replace existing permissions on all subfolders and files
  - 2 = Do not allow permissions to be replaced
- *var.gpo_security.kerberos_policy.max_clock_skew*
  - 0 - 99999
- *var.gpo_security.kerberos_policy.max_renew_age*
  - 0 - 99999
- *var.gpo_security.kerberos_policy.max_service_age*
  - 10 - value of *.max_ticket_age*
- *var.gpo_security.kerberos_policy.max_ticket_age*
  - 0 - 99999
- *var.gpo_security.kerberos_policy.ticket_validate_client*
  - 0
    - any other non-zero value disables the policy
- *var.gpo_security.password_policies.clear_text_password*
  - 0 = disable
  - 2<sup>1</sup> - 2<sup>16</sup> = enable and configure value
- *var.gpo_security.password_policies.maximum_password_age*
  - 0 - 9999 days
- *var.gpo_security.password_policies.minimum_password_age*
  - 0 - 9999 days
- *var.gpo_security.password_policies.minimum_password_length*
  - 0 = no password
  - 2<sup>1</sup> - 2<sup>16</sup> = enable and configure value
- *var.gpo_security.password_policies.password_complexity*
  - 0 = disable
  - 2<sup>1</sup> - 2<sup>16</sup> = enable
- *var.gpo_security.password_policies.password_history_size*
  - 0 = disable
  - 2<sup>1</sup> - 2<sup>16</sup> = enable and configure value
- *var.gpo_security.registry_keys.propagation_mode*
  - 0 = Propagate permissions to all subkeys
  - 1 = Replace existing permissions on all subkeys
  - 2 = Do not allow permissions to be replaced on the key
- *var.gpo_security.registry_values.value_type*
  - 1 = REG_SZ
  - 2 = REG_EXPAND_SZ
  - 3 = REG_BINARY
  - 4 = REG_DWORD
  - 5 = REG_MULTI_SZ
- *var.gpo_security.system_services.startup_type*
  - 2 = Automatic
  - 3 = Manual
  - 4 = Disabled

---
  
[Back to README.md](../README.md)  
