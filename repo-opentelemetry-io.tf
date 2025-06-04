module "repo-opentelemetry-io" {
  source = "./modules/repository"
  name   = "opentelemetry.io"
  description = "The OpenTelemetry website and documentation"
  topics = [
    "documentation",
    "opentelemetry",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_update_branch = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "branch-protection-rule-opentelemetry-io-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "main"
  additional_required_status_checks = [
    "BUILD and CHECK LINKS",
    "CSPELL page-local word list check",
    "EXPIRED FILE check",
    "FILE FORMAT",
    "FILENAME check",
    "I18N check",
    "MARKDOWN linter",
    "REFCACHE updates?",
    "SPELLING check",
    "WARNINGS in build log?",
  ]
  required_linear_history = true
  block_creations = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-io-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-io-0]
}

module "branch-protection-rule-opentelemetry-io-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-io-1]
}

module "branch-protection-rule-opentelemetry-io-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "opentelemetrybot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-io-2]
}

