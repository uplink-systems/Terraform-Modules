####################################################################################################
#   Active Directory: Group Policy resources                                                       #
####################################################################################################

module "group_policy" {
  source        = "github.com/uplink-systems/Terraform-Modules//modules/ad/group_policy"
  gpo           = {
    name            = "Terraform"
    domain          = var.ad_hostname
  }
  gplink        = {
    ou_1            = {
      target_dn       = "OU=ComputerOU,DC=example,DC=com"
      order           = 1
    }
    ou_2            = {
      target_dn       = "OU=UserOU,DC=example,DC=com"
    }
  }
  gpo_security    = {
    application_log   = {
      maximum_log_size      = "1024"
    }
    password_policies = {
      maximum_password_age  = "180"
    }
    filesystem        = [ {
        path                = "C:\temp"
        acl                 = "D:AR(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCLCSWLOCRRC;;;IU)S:(AU;FA;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)"
        },
    ]
    system_services   = [
      {
        service_name        = "AppVClient"
        startup_mode        = "4"
        acl                 = "D:AR(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCLCSWLOCRRC;;;IU)S:(AU;FA;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)"
      },
      {
        service_name        = "WinRM"
        acl                 = "D:AR(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCLCSWLOCRRC;;;IU)S:(AU;FA;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)"
      },
    ]
  }
}