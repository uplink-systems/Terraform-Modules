variable "gpo" {
  description = "Group policy object settings"
  type        = object({
    name        = string
    description = optional(string, null)
    domain      = optional(string, null)
    status      = optional(string, null)
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
      audit_log_retention_period    = optional(string, null)
      maximum_log_size              = optional(string, null)
      restrict_guest_access         = optional(string, null)
      retention_days                = optional(string, null)
    }))
    audit_log           = optional(object({
      audit_log_retention_period    = optional(string, null)
      maximum_log_size              = optional(string, null)
      restrict_guest_access         = optional(string, null)
      retention_days                = optional(string, null)
    }))
    event_audit         = optional(object({
      audit_account_logon           = optional(string, null)
      audit_account_manage          = optional(string, null)
      audit_ds_access               = optional(string, null)
      audit_logon_events            = optional(string, null)
      audit_object_access           = optional(string, null)
      audit_policy_change           = optional(string, null)
      audit_privilege_use           = optional(string, null)
      audit_process_tracking        = optional(string, null)
      audit_system_events           = optional(string, null)
    }))
    filesystem          = optional(list(object({
      path                          = string
      acl                           = string
      propagation_mode              = optional(string, "0")
    })))
    kerberos_policy     = optional(object({
      max_clock_skew                = optional(string, null)
      max_renew_age                 = optional(string, null)
      max_service_age               = optional(string, null)
      max_ticket_age                = optional(string, null)
      ticket_validate_client        = optional(string, null)
    }))
    password_policies   = optional(object({
      clear_text_password           = optional(string, null)
      maximum_password_age          = optional(string, null)
      minimum_password_age          = optional(string, null)
      minimum_password_length       = optional(string, null)
      password_complexity           = optional(string, null)
      password_history_size         = optional(string, null)
    }))
    registry_keys       = optional(list(object({
      key_name                      = string
      acl                           = string
      propagation_mode              = optional(string, "0")
    })))
    registry_values     = optional(list(object({
      key_name                      = string
      value                         = string
      value_type                    = optional(string, "1")
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
      startup_mode                  = optional(string, "2")
      acl                           = optional(string, "")
    })))
  })
  default     = { enabled = false }
}

