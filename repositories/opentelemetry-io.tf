module "opentelemetry-io-repo" {
  source = "../modules/repository"
  name   = "opentelemetry.io"
  description = "The OpenTelemetry website and documentation"
  topics = ["opentelemetry", "documentation"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
  vulnerability_alerts = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "opentelemetry-io-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-io-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["WARNINGS in build log?", "FILENAME check", "BUILD and CHECK LINKS", "SPELLING check", "I18N check", "FILE FORMAT", "REFCACHE updates?", "MARKDOWN linter", "CSPELL page-local word list check", "EXPIRED FILE check"]
  required_linear_history = true
  block_creations = true
  enforce_admins = false
}

module "opentelemetry-io-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-io-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-io-branch-protection-rule-0]
}

module "opentelemetry-io-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-io-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-io-branch-protection-rule-1]
}

module "opentelemetry-io-branch-protection-rule-3" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-io-repo.node_id
  pattern = "opentelemetrybot/**/*"
  depends_on = [module.opentelemetry-io-branch-protection-rule-2]
}

