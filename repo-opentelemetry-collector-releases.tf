module "repo-opentelemetry-collector-releases" {
  source = "./modules/repository"
  name   = "opentelemetry-collector-releases"
  description = "OpenTelemetry Collector Official Releases"
  topics = [
    "open-telemetry",
    "opentelemetry",
  ]
  has_wiki = true
  has_projects = true
  allow_update_branch = true
  vulnerability_alerts = false
}

module "branch-protection-rule-opentelemetry-collector-releases-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector-releases.node_id
  pattern = "main"
  additional_required_status_checks = [
    "Build",
  ]
  require_conversation_resolution = true
  block_creations = true
}

module "branch-protection-rule-opentelemetry-collector-releases-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-collector-releases.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-collector-releases-0]
}

module "branch-protection-rule-opentelemetry-collector-releases-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-collector-releases.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-collector-releases-1]
}

module "branch-protection-rule-opentelemetry-collector-releases-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector-releases.node_id
  pattern = "gh-readonly-queue/main/**"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-releases-2]
}

module "branch-protection-rule-opentelemetry-collector-releases-4" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector-releases.node_id
  pattern = "new-wildcard-rule"
  require_conversation_resolution = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-releases-3]
}

