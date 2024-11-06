####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "project" {
    description   = "project attributes"
    value         = azuredevops_project.project
}

output "project_pipeline_settings" {
    description   = "project_pipeline_settings attributes"
    value         = azuredevops_project_pipeline_settings.project_pipeline_settings
}
