## Module 'pki_1_tier'

### Description

This module creates a stand-alone certificate authority signing certificate.  
Optionally it also creates one ore multiple certificates or client auth, server auth and other usage signed by the certificate authority's signing certificate.  
The module is based on **[terraform-tls-pki](https://github.com/particuleio/terraform-tls-pki/tree/main)** by **[particuleio](https://github.com/particuleio)**. It is customized to my business needs and standards and extended with an export of the certificates as *.p12* files and *.txt* files with its passwords to the local file system.

> [!WARNING]
>The module's outputs may expose sensitive data like private keys and certificate passwords in the CLI as well as in the file system.  
>Therefore it should only be used internally, only by trusted admins and store its output to highly restricted locations.  
  
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_pkcs12"></a> [chilicat\/pkcs12](#requirement\_pkcs12) | ~> 0.2 |
| <a name="requirement_local"></a> [hashicorp\/local](#requirement\_local) | ~> 2.0 |
| <a name="requirement_random"></a> [hashicorp\/random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_tls"></a> [hashicorp\/tls](#requirement\_tls) | ~> 4.0 |

### Resources

| Name | Type |
|------|------|
| [random_password.ca](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [pkcs12_from_pem.ca](https://registry.terraform.io/providers/chilicat/pkcs12/latest/docs/resources/from_pem) | resource |
| [local_sensitive_file.ca](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.ca_password](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_password.certificate](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_cert_request.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [pkcs12_from_pem.certificate](https://registry.terraform.io/providers/chilicat/pkcs12/latest/docs/resources/from_pem) | resource |
| [local_sensitive_file.certificate](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.certificate_password](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca"></a> [ca](#input\_ca) | 'var.ca' is the main variable for the ca related resource settings | `any` | <pre>{<br>  "algorithm": "ECDSA",<br>  "allowed_uses": [<br>    "cert_signing",<br>    "client_auth",<br>    "code_signing",<br>    "crl_signing",<br>    "digital_signature",<br>    "key_encipherment",<br>    "ocsp_responder",<br>    "server_auth",<br>  ],<br>  "early_renewal_hours": 78840,<br>  "ecdsa_curve": "P384",<br>  "rsa_bits": 4096,<br>  "subject": {<br>    "common_name": "Certificate_Authority"<br>  },<br>  "validity_period_hours": 87600<br>}</pre> | no |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | 'var.certificates' is the main variable for the certificates related resource settings | `any` | `{}` | no |
| <a name="input_export"></a> [export](#input\_export) | 'var.export' is the main variable for the certificate file export settings | `any` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca"></a> [ca](#output\_ca) | list of ca attributes |
| <a name="output_ca_sensitive_data"></a> [ca_sensitive_data](#output\_ca\_sensitive\_data) | list of ca required sensitive attributes in clear-text |
| <a name="output_certificates"></a> [certificates](#output\_certificates) | list of certificates' attributes |
| <a name="output_certificates_sensitive_data"></a> [certificates_sensitive_data](#output\_certificates\_sensitive\_data) | list of certificates' required sensitive attributes in clear-text |

<details>
<summary><b>Using module output in root module</b></summary>

Output - PKCS12 CA certificate filepath/filename and password in clear-text using 'certificates_sensitive_data' output:

```
output "ca_file_password" {
  value     = {
    for k, v in module.pki.ca_sensitive_data : k => {
      pkcs12_file      = module.pki.ca_sensitive_data.pkcs12_file
      pkcs12_password  = module.pki.ca_sensitive_data.pkcs12_password
    }
  }
}
```
Output - PKCS12 certificates filepath/filename and password in clear-text using 'certificates_sensitive_data' output:

```
output "certificates_file_password" {
  value     = {
    for k, v in module.pki.certificates_sensitive_data : k => {
      pkcs12_file      = module.pki.certificates_sensitive_data[k].pkcs12_file
      pkcs12_password  = module.pki.certificates_sensitive_data[k].pkcs12_password
    }
  }
}
```
</details>

---
  
[Back to README.md](../README.md)  
