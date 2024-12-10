####################################################################################################
#   main.tf - Active Directory Group Policy                                                        #
####################################################################################################

resource "ad_gpo" "gpo" {
  name            = var.gpo.name
  description     = var.gpo.description
  domain          = var.gpo.domain
  status          = try(var.gpo.status, "AllSettingsEnabled")
}

resource "ad_gplink" "gplink" {
  for_each        = {for k, v in var.gplink : k => v if var.gplink != null}
  gpo_guid        = ad_gpo.gpo.id
  target_dn       = each.value.target_dn
  enforced        = each.value.enforced
  enabled         = each.value.enabled
  order           = try(each.value.order, null)
  depends_on      = [ ad_gpo.gpo ]
}

resource "ad_gpo_security" "gpo_security" {
  count           = var.gpo_security.enabled ? 1 : 0
  gpo_container   = ad_gpo.gpo.id
  account_lockout {
    force_logoff_when_hour_expire = try(var.gpo_security.account_lockout.force_logoff_when_hour_expire, null)
    lockout_bad_count             = try(var.gpo_security.account_lockout.lockout_bad_count, null)
    lockout_duration              = try(var.gpo_security.account_lockout.lockout_duration, null)
    reset_lockout_count           = try(var.gpo_security.account_lockout.reset_lockout_count, null)
  }
  password_policies {
    clear_text_password           = try(var.gpo_security.password_policies.clear_text_password, null)
    maximum_password_age          = try(var.gpo_security.password_policies.maximum_password_age, null)
    minimum_password_age          = try(var.gpo_security.password_policies.minimum_password_age, null)
    minimum_password_length       = try(var.gpo_security.password_policies.minimum_password_length, null)
    password_complexity           = try(var.gpo_security.password_policies.password_complexity, null)
    password_history_size         = try(var.gpo_security.password_policies.password_history_size, null)
  }
  kerberos_policy {
    max_clock_skew                = try(var.gpo_security.kerberos_policy.max_clock_skew, null)
    max_renew_age                 = try(var.gpo_security.kerberos_policy.max_renew_age, null)
    max_service_age               = try(var.gpo_security.kerberos_policy.max_service_age, null)
    max_ticket_age                = try(var.gpo_security.kerberos_policy.max_ticket_age, null)
    ticket_validate_client        = try(var.gpo_security.kerberos_policy.ticket_validate_client, null)
  }
  application_log {
    audit_log_retention_period    = try(var.gpo_security.application_log.audit_account_logon, null)
    maximum_log_size              = try(var.gpo_security.application_log.maximum_log_size, null)
    restrict_guest_access         = try(var.gpo_security.application_log.restrict_guest_access, null)
    retention_days                = try(var.gpo_security.application_log.retention_days, null)
  }
  audit_log {
    audit_log_retention_period    = try(var.gpo_security.audit_log.audit_account_logon, null)
    maximum_log_size              = try(var.gpo_security.audit_log.maximum_log_size, null)
    restrict_guest_access         = try(var.gpo_security.audit_log.restrict_guest_access, null)
    retention_days                = try(var.gpo_security.audit_log.retention_days, null)
  }
  system_log {
    audit_log_retention_period    = try(var.gpo_security.system_log.audit_account_logon, null)
    maximum_log_size              = try(var.gpo_security.system_log.maximum_log_size, null)
    restrict_guest_access         = try(var.gpo_security.system_log.restrict_guest_access, null)
    retention_days                = try(var.gpo_security.system_log.retention_days, null)
  }
  event_audit {
    audit_account_logon           = try(var.gpo_security.event_audit.audit_account_logon, null)
    audit_account_manage          = try(var.gpo_security.event_audit.audit_account_manage, null)
    audit_ds_access               = try(var.gpo_security.event_audit.audit_ds_access, null)
    audit_logon_events            = try(var.gpo_security.event_audit.audit_logon_events, null)
    audit_object_access           = try(var.gpo_security.event_audit.audit_object_access, null)
    audit_policy_change           = try(var.gpo_security.event_audit.audit_policy_change, null)
    audit_privilege_use           = try(var.gpo_security.event_audit.audit_privilege_use, null)
    audit_process_tracking        = try(var.gpo_security.event_audit.audit_process_tracking, null)
    audit_system_events           = try(var.gpo_security.event_audit.audit_system_events, null)
  }
  dynamic "filesystem" {
    for_each  = var.gpo_security.filesystem != null ? var.gpo_security.filesystem : []
    content {
      acl                             = filesystem.value.acl
      path                            = filesystem.value.path
      propagation_mode                = filesystem.value.propagation_mode
    }
  }
  dynamic "registry_keys" {
    for_each  = var.gpo_security.registry_keys != null ? var.gpo_security.registry_keys : []
    content {
      key_name                        = registry_keys.value.key_name
      acl                             = registry_keys.value.acl
      propagation_mode                = registry_keys.value.propagation_mode
    }
  }
  dynamic "registry_values" {
    for_each  = var.gpo_security.registry_values != null ? var.gpo_security.registry_values : []
    content {
      key_name                        = registry_values.value.key_name
      value                           = registry_values.value.value
      value_type                      = registry_values.value.value_type
    }
  }
  dynamic "restricted_groups" {
    for_each  = var.gpo_security.restricted_groups != null ? var.gpo_security.restricted_groups : []
    content {
      group_memberof                  = restricted_groups.value.group_memberof
      group_members                   = restricted_groups.value.group_members
      group_name                      = restricted_groups.value.group_name
    }
  }
  dynamic "system_services" {
    for_each  = var.gpo_security.system_services != null ? var.gpo_security.system_services : []
    content {
      service_name                    = system_services.value.service_name
      startup_mode                    = system_services.value.startup_mode
      acl                             = system_services.value.acl
    }
  }
  depends_on      = [ ad_gpo.gpo ]
}
