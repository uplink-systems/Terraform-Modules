####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  ca      = {
    name      = try(var.ca.subject.common_name, "Certificate Authority")
  }
  export  = {
    path    = try(var.export.path, "${path.cwd}/export/pkcs12")
  }
}
