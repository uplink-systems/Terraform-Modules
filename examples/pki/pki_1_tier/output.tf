####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "ca_file" {
  value     = {
      pkcs12_file     = module.pki.ca_sensitive_data.pkcs12_file
      pkcs12_password = module.pki.ca_sensitive_data.pkcs12_password
  }
}

output "certificates_files" {
  value     = {
    for k, v in module.pki.certificates_sensitive_data : k => {
      pkcs12_file     = module.pki.certificates_sensitive_data[k].pkcs12_file
      pkcs12_password = module.pki.certificates_sensitive_data[k].pkcs12_password
    }
  }
}
