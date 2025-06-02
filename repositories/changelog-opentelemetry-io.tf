module "changelog-opentelemetry-io-repo" {
  source = "../modules/repository"
  name   = "changelog.opentelemetry.io"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  vulnerability_alerts = true
}

module "changelog-opentelemetry-io-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.changelog-opentelemetry-io-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  restrict_pushes = false
}

module "changelog-opentelemetry-io-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.changelog-opentelemetry-io-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.changelog-opentelemetry-io-branch-protection-rule-0]
}

module "changelog-opentelemetry-io-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.changelog-opentelemetry-io-repo.node_id
  pattern = "gh-readonly-queue/main/*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.changelog-opentelemetry-io-branch-protection-rule-1]
}

