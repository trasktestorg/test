module "opentelemetry-dotnet-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-dotnet-contrib"
  description = "This repository contains set of components extending functionality of the OpenTelemetry .NET SDK. Instrumentation libraries, exporters, and other components can find their home here."
  topics = [
    "dotnet",
    "dotnet-core",
    "opentelemetry",
  ]
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  secret_scanning_status = "enabled"
}

module "opentelemetry-dotnet-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-contrib-repo.node_id
  pattern = "main*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  enforce_admins = false
}

module "opentelemetry-dotnet-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-contrib-repo.node_id
  pattern = "instrumentation*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  push_allowances = ["open-telemetry/dotnet-contrib-approvers"]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.opentelemetry-dotnet-contrib-branch-protection-rule-0]
}

module "opentelemetry-dotnet-contrib-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-contrib-repo.node_id
  pattern = "exporter*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  push_allowances = ["open-telemetry/dotnet-contrib-approvers"]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.opentelemetry-dotnet-contrib-branch-protection-rule-1]
}

module "opentelemetry-dotnet-contrib-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-contrib-repo.node_id
  pattern = "extensions*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  push_allowances = ["open-telemetry/dotnet-contrib-approvers"]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.opentelemetry-dotnet-contrib-branch-protection-rule-2]
}

module "opentelemetry-dotnet-contrib-branch-protection-rule-4" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-dotnet-contrib-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.opentelemetry-dotnet-contrib-branch-protection-rule-3]
}

