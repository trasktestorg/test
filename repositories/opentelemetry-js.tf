module "opentelemetry-js-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-js"
  description = "OpenTelemetry JavaScript Client"
  topics = [
    "api",
    "distributed-tracing",
    "metrics",
    "monitoring",
    "telemetry",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  has_pages = true
}

module "opentelemetry-js-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-js-repo.node_id
  pattern = "main"
  additional_required_status_checks = [
    "browser-tests",
    "node-tests (18)",
    "node-tests (20)",
    "node-tests (22)",
    "node-windows-tests",
    "webworker-tests",
  ]
  restrict_pushes = false
}

module "opentelemetry-js-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-js-repo.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  depends_on = [module.opentelemetry-js-branch-protection-rule-0]
}

module "opentelemetry-js-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-js-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-js-branch-protection-rule-1]
}

module "opentelemetry-js-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-js-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  depends_on = [module.opentelemetry-js-branch-protection-rule-2]
}

