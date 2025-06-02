module "opentelemetry-go-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-go"
  description = "OpenTelemetry Go API and SDK"
  homepage_url = "https://opentelemetry.io/docs/languages/go"
  topics = ["tracing", "metrics", "opentelemetry", "logging"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
}

module "opentelemetry-go-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-go-repo.node_id
  pattern = "main"
  restrict_dismissals = true
  additional_required_status_checks = ["lint", "test-coverage", "test-race", "test-compatibility"]
  require_conversation_resolution = true
}

module "opentelemetry-go-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-go-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-go-branch-protection-rule-0]
}

module "opentelemetry-go-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-go-repo.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.opentelemetry-go-branch-protection-rule-1]
}

module "opentelemetry-go-branch-protection-rule-3" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-go-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-go-branch-protection-rule-2]
}

module "opentelemetry-go-branch-protection-rule-4" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-go-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
  depends_on = [module.opentelemetry-go-branch-protection-rule-3]
}

