####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "ad_gpo" {
  description = "output the ad_gpo resource attributes/values"
  value       = ad_gpo.gpo
  depends_on  = [ ad_gpo.gpo ]
}

output "ad_gplink" {
  description = "output the ad_gplink resource attributes/values as list(object)"
  value       = values(ad_gplink.gplink).*
  depends_on  = [ ad_gplink.gplink ]
}

output "ad_gpo_security" {
  description = "output the ad_gpo_security resource attributes/values"
  value       = ad_gpo_security.gpo_security
  depends_on  = [ ad_gpo_security.gpo_security ]
}