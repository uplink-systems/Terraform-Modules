####################################################################################################
#   Variable values:                                                                               #
#   Azure AD dynamic membership security groups                                                    # 
####################################################################################################

azuread_group_security_dynamic = {
  "AAD-Group-Security_Dynamic-AllUser" = {
    display_name              = "AAD-Group-Security_Dynamic-AllUser"
    rule                      = "(user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.employeeId -ne \"Administrator\") and (user.companyName -eq \"example.onmicrosoft.com\")"
    description               = "Description for AAD-Group-Security_Dynamic-AllUser"
    assignable_to_role        = false
    lifecycle_prevent_destroy = true
  }
  "AAD-Group-Security_Dynamic-AllAdmins" = {
    display_name              = "AAD-Group-Security_Dynamic-AllAdmins"
    rule                      = "(user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.employeeId -eq \"Administrator\") and (user.companyName -eq \"example.onmicrosoft.com\")"
    description               = "Description for AAD-Group-Security_Dynamic-AllAdmins"
    assignable_to_role        = false
  }
}

####################################################################################################
#   Variable values:                                                                               #
#   Azure AD assigned membership security groups                                                   # 
####################################################################################################

azuread_group_security_assigned = {
  "AAD-Group-Security_Assigned-01" = {
    display_name  = "AAD-Group-Security_Assigned-01"
    description   = "Description for AAD-Group-Security_Assigned-01"
    member_groups = [
    ]
    member_users  = [
      "user.01@example.onmicrosoft.com",
      "user.02@example.onmicrosoft.com",
    ]
    owners  = [
      "admin@example.onmicrosoft.com",
    ]
  }
  "AAD-Group-Security_Assigned-02" = {
    display_name  = "AAD-Group-Security_Assigned-02"
    description   = "Description for AAD-Group-Security_Assigned-02"
    member_groups = [
    ]
    member_users  = [
      "user.03@example.onmicrosoft.com",
      "user.04@example.onmicrosoft.com",
    ]
  }
}