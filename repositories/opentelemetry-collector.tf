module "opentelemetry-collector-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-collector"
  description = "OpenTelemetry Collector"
  topics = ["opentelemetry", "open-telemetry", "telemetry", "metrics", "monitoring", "observability"]
  has_wiki = true
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_title = "PR_TITLE"
  allow_update_branch = true
  allow_auto_merge = true
}

module "opentelemetry-collector-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["lint", "changelog", "checks", "contrib_tests", "unittest", "Check", "windows-unittest (windows-2025)", "windows-unittest (windows-2022)"]
  block_creations = true
}

module "opentelemetry-collector-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-collector-repo.node_id
  pattern = "renovate/**/**"
  enforce_admins = true
  depends_on = [module.opentelemetry-collector-branch-protection-rule-0]
}

module "opentelemetry-collector-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-collector-repo.node_id
  pattern = "dependabot/**/**"
  enforce_admins = true
  depends_on = [module.opentelemetry-collector-branch-protection-rule-1]
}

module "opentelemetry-collector-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-repo.node_id
  pattern = "gh-readonly-queue/main/**"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.opentelemetry-collector-branch-protection-rule-2]
}

module "opentelemetry-collector-branch-protection-rule-4" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-collector-repo.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.opentelemetry-collector-branch-protection-rule-3]
}

