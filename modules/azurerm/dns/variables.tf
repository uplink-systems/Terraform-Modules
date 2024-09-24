variable "name" {
  description = "DNS zone's name in FQDN format"
}
variable "resource_group_name" {
  description = "DNS zone's resource group name to assign to"
}
variable "tags" {
  description = "DNS zone's tags to apply"
}
variable "recordset_a" {
  description = "DNS zone's record set resources of record type 'A'"
}
variable "recordset_aaaa" {
  description = "DNS zone's record set resources of record type 'AAA'"
}
variable "recordset_caa" {
  description = "DNS zone's record set resources of record type 'CAA'"
}
variable "recordset_cname" {
  description = "DNS zone's record set resources of record type 'CNAME'"
}
variable "recordset_mx" {
  description = "DNS zone's record set resources of record type 'MX'"
}
variable "recordset_ns" {
  description = "DNS zone's record set resources of record type 'NS'"
}
variable "recordset_srv" {
  description = "DNS zone's record set resources of record type 'SRV'"
}
variable "recordset_txt" {
  description = "DNS zone's record set resources of record type 'TXT'"
}