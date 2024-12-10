####################################################################################################
#   Provider configuration                                                                         # 
####################################################################################################

provider "ad" {
  winrm_hostname  = var.ad_hostname
  winrm_username  = var.ad_user
  winrm_password  = var.ad_password
}
