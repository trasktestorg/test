module "repo-changelog-opentelemetry-io" {
  source = "./modules/repository"
  name   = "changelog.opentelemetry.io"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
}

module "branch-protection-rule-changelog-opentelemetry-io-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-changelog-opentelemetry-io.node_id
  pattern = "main"
  required_status_checks_strict = false
  restrict_pushes = false
}

module "branch-protection-rule-changelog-opentelemetry-io-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-changelog-opentelemetry-io.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-changelog-opentelemetry-io-0]
}

module "branch-protection-rule-changelog-opentelemetry-io-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-changelog-opentelemetry-io.node_id
  pattern = "gh-readonly-queue/main/*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-changelog-opentelemetry-io-1]
}

