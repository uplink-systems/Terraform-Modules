####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "ca" {
  value     = {
    private_key         = tls_private_key.ca
    cert                = tls_self_signed_cert.ca
  }
  sensitive = true
}

output "ca_sensitive_data" {
  value     = {
    pkcs12_file         = local_sensitive_file.ca.filename
    pkcs12_password     = nonsensitive(pkcs12_from_pem.ca.password)
    private_key_pem     = nonsensitive(tls_private_key.ca.private_key_pem)
    cert_pem            = nonsensitive(tls_self_signed_cert.ca.cert_pem)
  }
}

output "certificates" {
  value     = {
    for k, v in var.certificates : k => {
      private_key       = tls_private_key.certificate[k]
      cert              = tls_locally_signed_cert.certificate[k]
      pkcs12_bundle_b64 = {
        password          = pkcs12_from_pem.certificate[k].password
        content           = pkcs12_from_pem.certificate[k].result
      }
    }
  }
  sensitive = true
}

output "certificates_sensitive_data" {
  value     = {
    for k, v in var.certificates : k => {
      pkcs12_file         = local_sensitive_file.certificate[k].filename
      pkcs12_password     = nonsensitive(pkcs12_from_pem.certificate[k].password)
      private_key_pem     = nonsensitive(tls_private_key.certificate[k].private_key_pem)
      cert_pem            = nonsensitive(tls_locally_signed_cert.certificate[k].cert_pem)
    }
  }
}
