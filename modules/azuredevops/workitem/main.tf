####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuredevops_workitem" "workitem" {
  title           = var.workitem.title
  project_id      = var.workitem.project_id
  type            = var.workitem.type
  area_path       = var.workitem.area_path
  custom_fields   = var.workitem.custom_fields
  iteration_path  = var.workitem.iteration_path
  state           = var.workitem.state
  tags            = var.workitem.tags
  lifecycle {
    ignore_changes = [ state ]
  }
}
