####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

###  configure/deploy Certificate Authority's self-signed root certificate

resource "random_password" "ca" {
  length                = 32
}

resource "tls_private_key" "ca" {
  algorithm             = try(var.ca.algorithm, "ECDSA")
  ecdsa_curve           = try(var.ca.algorithm, "ECDSA") == "ECDSA" ? try(var.ca.ecdsa_curve, "P384") : null
  rsa_bits              = try(var.ca.algorithm, "ECDSA") == "RSA" ? try(var.ca.rsa_bits, 4096) : null
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem       = tls_private_key.ca.private_key_pem
  allowed_uses          = try(var.ca.allowed_uses, [
    "cert_signing",
    "client_auth",
    "code_signing",
    "crl_signing",
    "digital_signature",
    "key_encipherment",
    "ocsp_signing",
    "server_auth",
  ])
  early_renewal_hours   = try(var.ca.early_renewal_hours, 2160)
  is_ca_certificate     = true
  set_subject_key_id    = try(var.ca.set_subject_key_id, true)
  subject {
    common_name           = try(var.ca.subject.common_name, "Certificate_Authority")
    organization          = try(var.ca.subject.organization, null)
    organizational_unit   = try(var.ca.subject.organizational_unit, null)
    country               = try(var.ca.subject.country, null)
    postal_code           = try(var.ca.subject.postal_code, null)
    street_address        = try(var.ca.subject.street_address, null)
    locality              = try(var.ca.subject.locality, null)
    province              = try(var.ca.subject.province, null)
    serial_number         = try(var.ca.subject.serial_number, null)
  }
  validity_period_hours = try(var.ca.validity_period_hours, 87600)
  depends_on            = [ tls_private_key.ca ]
}

resource "pkcs12_from_pem" "ca" {
  password              = random_password.ca.result
  private_key_pem       = tls_private_key.ca.private_key_pem
  cert_pem              = tls_self_signed_cert.ca.cert_pem
  depends_on            = [ tls_self_signed_cert.ca, random_password.ca ]
}

resource "local_sensitive_file" "ca" {
  filename              = "${local.export.path}/${local.ca.name}.p12"
  content_base64        = pkcs12_from_pem.ca.result
  depends_on            = [ pkcs12_from_pem.ca ]
}

resource "local_sensitive_file" "ca_password" {
  filename              = "${local.export.path}/${local.ca.name}.txt"
  content               = random_password.ca.result
  depends_on            = [ random_password.ca ]
}

###  configure/deploy certificate(s) locally signed by the Certificate Authority's root certificate

resource "random_password" "certificate" {
  for_each              = var.certificates
  length                = 16
}

resource "tls_private_key" "certificate" {
  for_each              = var.certificates
  algorithm             = try(each.value.algorithm, "ECDSA")
  ecdsa_curve           = try(each.value.algorithm, "ECDSA") == "ECDSA" ? try(each.value.ecdsa_curve, "P384") : null
  rsa_bits              = try(each.value.algorithm, "ECDSA") == "RSA" ? try(each.value.rsa_bits, 4096) : null
  depends_on            = [ tls_self_signed_cert.ca ]
}

resource "tls_cert_request" "certificate" {
  for_each              = var.certificates
  private_key_pem       = tls_private_key.certificate[each.key].private_key_pem
  subject {
    common_name           = try(each.value.subject.common_name, null)
    organization          = try(each.value.subject.organization, null)
    organizational_unit   = try(each.value.subject.organizational_unit, null)
    street_address        = try(each.value.subject.street_address, null)
    locality              = try(each.value.subject.locality, null)
    province              = try(each.value.subject.province, null)
    country               = try(each.value.subject.country, null)
    postal_code           = try(each.value.subject.postal_code, null)
    serial_number         = try(each.value.subject.serial_number, null)
  }
  dns_names             = try(each.value.dns_names, [])
  ip_addresses          = try(each.value.ip_addresses, [])
  uris                  = try(each.value.uris, [])
  depends_on            = [ tls_private_key.certificate ]
}

resource "tls_locally_signed_cert" "certificate" {
  for_each              = var.certificates
  cert_request_pem      = tls_cert_request.certificate[each.key].cert_request_pem
  ca_private_key_pem    = tls_private_key.ca.private_key_pem
  ca_cert_pem           = tls_self_signed_cert.ca.cert_pem
  allowed_uses          = try(each.value.allowed_uses, [])
  early_renewal_hours   = try(each.value.early_renewal_hours, 720)
  is_ca_certificate     = false
  set_subject_key_id    = try(each.value.set_subject_key_id, false)
  validity_period_hours = try(each.value.validity_period_hours, 8740)
  depends_on            = [ tls_cert_request.certificate ]
}

resource "pkcs12_from_pem" "certificate" {
  for_each              = var.certificates
  password              = random_password.certificate[each.key].result
  ca_pem                = tls_self_signed_cert.ca.cert_pem
  cert_pem              = tls_locally_signed_cert.certificate[each.key].cert_pem
  private_key_pem       = tls_private_key.certificate[each.key].private_key_pem
  depends_on            = [ tls_locally_signed_cert.certificate, random_password.certificate ]
}

resource "local_sensitive_file" "certificate" {
  for_each              = var.certificates
  filename              = "${local.export.path}/${local.ca.name}_${each.key}.p12"
  content_base64        = pkcs12_from_pem.certificate[each.key].result
  depends_on            = [ pkcs12_from_pem.certificate ]
}

resource "local_sensitive_file" "certificate_password" {
  for_each              = var.certificates
  filename              = "${local.export.path}/${local.ca.name}_${each.key}.txt"
  content               = random_password.certificate[each.key].result
  depends_on            = [ random_password.certificate ]
}
