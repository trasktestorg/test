module "opentelemetry-collector-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-collector-contrib"
  description = "Contrib repository for the OpenTelemetry Collector"
  topics = ["opentelemetry", "open-telemetry"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
  vulnerability_alerts = true
  has_pages = true
  pages_source_branch = "benchmarks"
  pages_path = "/docs"
}

module "opentelemetry-collector-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-contrib-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["integration-tests", "lint", "changelog", "correctness-traces", "correctness-metrics", "checks", "check-collector-module-version", "windows-unittest", "unittest", "scoped-tests"]
  block_creations = true
}

module "opentelemetry-collector-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-contrib-repo.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.opentelemetry-collector-contrib-branch-protection-rule-0]
}

module "opentelemetry-collector-contrib-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-collector-contrib-repo.node_id
  pattern = "dependabot/**/**"
  enforce_admins = true
  depends_on = [module.opentelemetry-collector-contrib-branch-protection-rule-1]
}

module "opentelemetry-collector-contrib-branch-protection-rule-3" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-collector-contrib-repo.node_id
  pattern = "renovate/**/**"
  enforce_admins = true
  depends_on = [module.opentelemetry-collector-contrib-branch-protection-rule-2]
}

module "opentelemetry-collector-contrib-branch-protection-rule-4" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-collector-contrib-repo.node_id
  pattern = "**/**"
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.opentelemetry-collector-contrib-branch-protection-rule-3]
}

