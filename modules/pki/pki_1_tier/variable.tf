####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "ca" {
  description = "Attributes/values for Certificate Authority's self-signed certificate"
  type        = any
  default     = {
    "algorithm": "ECDSA",
    "allowed_uses": [
      "cert_signing",
      "client_auth",
      "code_signing",
      "crl_signing",
      "digital_signature",
      "key_encipherment",
      "ocsp_responder",
      "server_auth",
    ],
    "early_renewal_hours": 78840,
    "ecdsa_curve": "P384",
    "rsa_bits": 4096,
    "subject": {
      "common_name": "Certificate_Authority"
    },
    "validity_period_hours": 87600
  }
}

variable "certificates" {
  description = "Attributes/values for Certificate Authority's locally-signed certificates"
  type        = any
  default     = {}
}

variable "export" {
  description = "Attributes/values for certificate file export"
  type        = any
  default     = {}
}