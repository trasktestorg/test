module "opentelemetry-java-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-java-contrib"
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "opentelemetry-java-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-contrib-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check", "gradle-wrapper-validation"]
}

module "opentelemetry-java-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-contrib-repo.node_id
  pattern = "release/*"
  additional_required_status_checks = ["gradle-wrapper-validation", "required-status-check", "CodeQL"]
  depends_on = [module.opentelemetry-java-contrib-branch-protection-rule-0]
}

module "opentelemetry-java-contrib-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-contrib-repo.node_id
  pattern = "v0.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.opentelemetry-java-contrib-branch-protection-rule-1]
}

module "opentelemetry-java-contrib-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-contrib-repo.node_id
  pattern = "v1.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.opentelemetry-java-contrib-branch-protection-rule-2]
}

module "opentelemetry-java-contrib-branch-protection-rule-4" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-java-contrib-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-java-contrib-branch-protection-rule-3]
}

module "opentelemetry-java-contrib-branch-protection-rule-5" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-java-contrib-repo.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.opentelemetry-java-contrib-branch-protection-rule-4]
}

