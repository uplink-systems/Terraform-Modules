####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

module "pki_1_tier" {
  source = "github.com/uplink-systems/Terraform-Modules//modules/pki/pki_1_tier"
  ca    = {
    algorithm   = "ECDSA"
    ecdsa_curve = "P384"
    subject = {
      common_name         = "RootCA"
      organization        = "Org"
      organizational_unit = "OU"
      street_address = [
        "Street"
      ]
      locality      = "Locality"
      province      = "Province"
      country       = "Country"
      postal_code   = "Postal Code"
      serial_number = "Serial Number"
    }
    validity_period_hours = 87600
    allowed_uses = [
      "cert_signing",
      "client_auth",
      "code_signing",
      "crl_signing",
      "digital_signature",
      "key_encipherment",
      "ocsp_signing",
      "server_auth",
    ]
  }
  certificates = {
    nas01 = {
      algorithm   = "ECDSA"
      ecdsa_curve = "P384"
      subject = {
        common_name         = "NAS01"
        organization        = "Example GmbH"
        organizational_unit = "IT"
        street_address = [
          "Example Stasse 1"
        ]
        country       = "DE"
        locality      = "Munich"
        province      = "BY"
        postal_code   = "80331"
      }
      validity_period_hours = 8740
      early_renewal_hours   = 8040
      dns_names = [
        "nas01",
        "nas01.example.com",
      ]
      ip_addresses = [
        "192.168.1.21"
      ]
      uris = []
      allowed_uses = [
        "server_auth",
        "client_auth",
      ]
    }
    esx01 = {
      subject = {
        common_name         = "ESX01"
        organization        = "Example GmbH"
        organizational_unit = "IT"
        street_address = [
          "Example Stasse 1"
        ]
        country       = "DE"
        locality      = "Munich"
        province      = "BY"
        postal_code   = "80331"
      }
      validity_period_hours = 8740
      early_renewal_hours   = 8040
      dns_names = [
        "esx01",
        "esx01.example.com"
      ]
      ip_addresses = [
        "192.168.1.101"
      ]
      allowed_uses = [
        "server_auth",
        "client_auth",
      ]
    }
  }
}