module "opentelemetry-dotnet-instrumentation-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-dotnet-instrumentation"
  description = "OpenTelemetry .NET Automatic Instrumentation"
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
}

module "opentelemetry-dotnet-instrumentation-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-instrumentation-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["check-native-headers", "check-native-format (windows-2022)", "test-jobs", "check-sdk-versions", "check-native-format (ubuntu-22.04)", "check-native-format (macos-13-xlarge)"]
  required_linear_history = true
  enforce_admins = false
}

module "opentelemetry-dotnet-instrumentation-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-instrumentation-repo.node_id
  pattern = "out-of-process-collection"
  required_approving_review_count = 0
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.opentelemetry-dotnet-instrumentation-branch-protection-rule-0]
}

