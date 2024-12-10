variable "gpo" {
  description = "Group policy object settings"
  type        = object({
    name        = string
    description = optional(string, null)
    domain      = optional(string, null)
    status      = optional(string, null)    # AllSettingsEnabled, UserSettingsDisabled, ComputerSettingsDisabled, AllSettingsDisabled (case sensitive)
  })
}

variable "gplink" {
  description = "Group policy link settings"
  type        = map(object({
    target_dn   = string
    enforced    = optional(bool, false)
    enabled     = optional(bool, true)
    order       = optional(number, null)
  }))
  default = {}
}

variable "gpo_security" {
  description = "Computer Configuration -> Policies -> Windows Settings -> Security Settings"
  type        = object({
    enabled            = optional(bool, true)
    account_lockout    = optional(object({
      force_logoff_when_hour_expire = optional(string, null)
      lockout_bad_count             = optional(string, null)
      lockout_duration              = optional(string, null)
      reset_lockout_count           = optional(string, null)
    }))
    application_log     = optional(object({
      audit_log_retention_period    = optional(string, null)    # 0: overwrite events as needed, 1: overwrite events as specified specified by retention_days, 2: never overwrite events.
      maximum_log_size              = optional(string, null)    # 64 - 4194240 KB
      restrict_guest_access         = optional(string, null)
      retention_days                = optional(string, null)    # 1 - 365
    }))
    audit_log           = optional(object({
      audit_log_retention_period    = optional(string, null)
      maximum_log_size              = optional(string, null)
      restrict_guest_access         = optional(string, null)
      retention_days                = optional(string, null)
    }))
    event_audit         = optional(object({
      audit_account_logon           = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_account_manage          = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_ds_access               = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_logon_events            = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_object_access           = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_policy_change           = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_privilege_use           = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_process_tracking        = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
      audit_system_events           = optional(string, null)  # 0 (None), 1 (Success audits only), 2 (Failure audits only), 3 (Success and failure audits), 4 (None) 
    }))
    filesystem          = optional(list(object({
      path                          = string
      acl                           = string
      propagation_mode              = optional(string, "0")  # 0: Propagate permissions to all subfolders and files, 1: Replace existing permissions on all subfolders and files, 2: Do not allow permissions to be replaced.
    })))
    kerberos_policy     = optional(object({
      max_clock_skew                = optional(string, null)  # 0 - 99999
      max_renew_age                 = optional(string, null)  # 0 - 99999
      max_service_age               = optional(string, null)  # 10 - max_ticket_age
      max_ticket_age                = optional(string, null)  # 0 - 99999
      ticket_validate_client        = optional(string, null)  # 0 (A non-zero value disables the policy)
    }))
    password_policies   = optional(object({
      clear_text_password           = optional(string, null)  # 0 - 2^16 -> 0 = off - any other = on
      maximum_password_age          = optional(string, null)  # 0 - 999 days
      minimum_password_age          = optional(string, null)  # 0 - 999 days
      minimum_password_length       = optional(string, null)  # 0 - 2^16 -> 0 = no password
      password_complexity           = optional(string, null)  # 0 - 2^16 -> 0 = off - any other = on
      password_history_size         = optional(string, null)  # 0 - 2^16 -> 0 = off - any other = on
    }))
    registry_keys       = optional(list(object({
      key_name                      = string
      acl                           = string
      propagation_mode              = optional(string, "0")    # 0: Propagate permissions to all subkeys, 1: Replace existing permissions on all subkeys, 2: Do not allow permissions to be replaced on the key.
    })))
    registry_values     = optional(list(object({
      key_name                      = string
      value                         = string
      value_type                    = optional(string, "1")    # 1: String, 2: Expand String, 3: Binary, 4: DWORD, 5: MULTI_SZ
    })))
    restricted_groups   = optional(list(object({
      group_name                    = string
      group_memberof                = optional(string, "")
      group_members                 = optional(string, "")
    })))
    system_log         = optional(object({
      audit_log_retention_period    = optional(string, null)
      maximum_log_size              = optional(string, null)
      restrict_guest_access         = optional(string, null)
      retention_days                = optional(string, null)
    }))
    system_services     = optional(list(object({
      service_name                  = string
      startup_mode                  = optional(string, "2")    # 2: Automatic, 3: Manual, 4: Disabled
      acl                           = optional(string, "")
    })))
  })
  default     = { enabled = false }
}

