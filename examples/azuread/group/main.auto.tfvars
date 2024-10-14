####################################################################################################
#   Azure AD: Groups                                                                               #
#   Variable values: Security Assigned, Security Dynamic, Unified Assigned, Unified Dynamic        #
####################################################################################################

azuread_group = {
  "AAD-Terraform-Security_Assigned" = {
    display_name          = "AAD-Terraform-Security_Assigned"
    description           = "AAD-Terraform-Security_Assigned group"
    member_groups         = [
    ]
    member_users          = [
      "user.01@company.onmicrosoft.com",
      "user.02@company.onmicrosoft.com",
    ]
  }
  "AAD-Terraform-Security_Dynamic" = {
    display_name          = "AAD-Terraform-Security_Dynamic"
    description           = "AAD-Terraform-Security_Dynamic group"
    assignable_to_role    = false
    dynamic_membership = {
      enabled             = true
      rule                = "(user.accountEnabled -eq true) and (user.companyName -eq \"company.onmicrosoft.com\")"
    }
    types                 = [
      "DynamicMembership",
    ]
  }
  "AAD-Terraform-Unified_Assigned" = {
    display_name          = "AAD-Terraform-Unified_Assigned"
    description           = "AAD-Terraform-Unified_Assigned group"
    behaviors             = [
      "HideGroupInOutlook",
      "SubscribeNewGroupMembers",
      "WelcomeEmailDisabled",
    ]
    mail_enabled          = true
    mail_nickname         = "AAD-Terraform-Unified_Assigned"
    member_groups         = [
    ]
    member_users          = [
      "user.01@company.onmicrosoft.com",
    ]
    types                 = [
      "Unified",
    ]
  }
  "AAD-Terraform-Unified_Dynamic" = {
    display_name          = "AAD-Terraform-Unified_Dynamic"
    description           = "AAD-Terraform-Unified_Dynamic group"
    behaviors             = [
      "HideGroupInOutlook",
      "SubscribeNewGroupMembers",
      "WelcomeEmailDisabled",
    ]
    mail_nickname         = "AAD-Terraform-Unified_Dynamic"
    dynamic_membership = {
      enabled             = true
      rule                = "(user.accountEnabled -eq true) and (user.companyName -eq \"company.onmicrosoft.com\")"
    }
    mail_enabled          = true
    owners                = [
      "administrator@company.onmicrosoft.com",
    ]
    provisioning_options  = ["Team"]
    types                 = [
      "DynamicMembership",
      "Unified",
    ]
  }
}
