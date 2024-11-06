####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "azuredevops_project" "project" {
  name                = var.project.name
  description         = var.project.description
  features            = {
    artifacts           = var.project.features.artifacts
    boards              = var.project.features.boards
    repositories        = var.project.features.repositories
    pipelines           = var.project.features.pipelines
    testplans           = var.project.features.testplans
  }
  visibility          = var.project.visibility
  version_control     = var.project.version_control
  work_item_template  = var.project.work_item_template
}

resource "azuredevops_project_pipeline_settings" "project_pipeline_settings" {
  project_id                            = azuredevops_project.project.id
  enforce_job_scope                     = var.project_pipeline_settings.enforce_job_scope
  enforce_job_scope_for_release         = var.project_pipeline_settings.enforce_job_scope_for_release
  enforce_referenced_repo_scoped_token  = var.project_pipeline_settings.enforce_referenced_repo_scoped_token
  enforce_settable_var                  = var.project_pipeline_settings.enforce_settable_var
  publish_pipeline_metadata             = var.project_pipeline_settings.publish_pipeline_metadata
  status_badges_are_private             = var.project_pipeline_settings.status_badges_are_private
}
