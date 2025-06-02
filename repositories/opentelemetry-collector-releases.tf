module "opentelemetry-collector-releases-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-collector-releases"
  description = "OpenTelemetry Collector Official Releases"
  topics = ["opentelemetry", "open-telemetry"]
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
}

module "opentelemetry-collector-releases-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-releases-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["Build"]
  require_conversation_resolution = true
  block_creations = true
}

module "opentelemetry-collector-releases-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-collector-releases-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-collector-releases-branch-protection-rule-0]
}

module "opentelemetry-collector-releases-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-collector-releases-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-collector-releases-branch-protection-rule-1]
}

module "opentelemetry-collector-releases-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-releases-repo.node_id
  pattern = "gh-readonly-queue/main/**"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.opentelemetry-collector-releases-branch-protection-rule-2]
}

module "opentelemetry-collector-releases-branch-protection-rule-4" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-collector-releases-repo.node_id
  pattern = "new-wildcard-rule"
  require_conversation_resolution = true
  allows_deletion = true
  depends_on = [module.opentelemetry-collector-releases-branch-protection-rule-3]
}

