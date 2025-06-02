module "opentelemetry-php-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-php-contrib"
  description = "opentelemetry-php-contrib"
  has_issues = false
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  vulnerability_alerts = true
  secret_scanning_status = "enabled"
}

module "opentelemetry-php-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-php-contrib-repo.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
}

module "opentelemetry-php-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-php-contrib-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.opentelemetry-php-contrib-branch-protection-rule-0]
}

module "opentelemetry-php-contrib-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-php-contrib-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-php-contrib-branch-protection-rule-1]
}

