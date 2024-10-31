####################################################################################################
#   main.tf                                                                                        # 
####################################################################################################

resource "azuread_invitation" "invitation" {
  user_display_name   = var.invitation.user_display_name
  user_email_address  = var.invitation.user_email_address
  dynamic "message" {
    for_each          = var.invitation.message.enabled ? [1] : []
    content {
      additional_recipients = var.invitation.message.additional_recipients
      body                  = var.invitation.message.body
      language              = var.invitation.message.body == null ? var.invitation.message.language : null
    }
  }
  redirect_url        = var.invitation.redirect_url
  user_type           = var.invitation.user_type
  lifecycle {
    ignore_changes    = [ message ]
  }
}
