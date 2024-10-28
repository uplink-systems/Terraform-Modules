####################################################################################################
#   Azure AD Invitations (Guest users)                                                             # 
####################################################################################################

resource "azuread_invitation" "invitation" {
  user_display_name   = var.user_display_name
  user_email_address  = var.user_email_address
  message {
    additional_recipients = var.message.additional_recipients
    body                  = var.message.body
    language              = var.message.body == null ? var.message.language : null
  }
  redirect_url        = var.redirect_url
  user_type           = var.user_type
  lifecycle {
    ignore_changes    = [ var.message ]
  }
}
