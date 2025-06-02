module "opentelemetry-cpp-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-cpp"
  description = "The OpenTelemetry C++ Client"
  homepage_url = "https://opentelemetry.io/"
  topics = ["distributed-tracing", "metrics", "telemetry", "sdk", "api", "opentelemetry"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
  vulnerability_alerts = true
  secret_scanning_status = "enabled"
  has_pages = true
}

module "opentelemetry-cpp-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-cpp-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["Bazel", "Bazel Windows", "Bazel on MacOS", "Format", "DocFX check", "markdown-lint", "misspell"]
  required_linear_history = true
}

module "opentelemetry-cpp-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-cpp-repo.node_id
  pattern = "async-changes"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.opentelemetry-cpp-branch-protection-rule-0]
}

