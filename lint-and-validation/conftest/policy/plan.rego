package plan

deny[msg] {
  changes := input.resource_changes[_]
  changes.type = "google_project_service"
  changes[_].after.disable_on_destroy == true

  msg := "google_project_service.disable_on_destroy must be false not to disable APIs unintentionally."
}

warning[msg] {
  changes := input.resource_changes[_]
  changes.type = "google_project_iam_member"
  changes[_].after.role == "roles/admin"
  is_production(changes[_].after.project)
  
  msg := "Admin role is not allowed in prod because of zero touch production."
}

is_production(project) {
  endswith(project, "prod")
}
