module "opentelemetry-js-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-js-contrib"
  description = "OpenTelemetry instrumentation for JavaScript modules"
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
}

module "opentelemetry-js-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-js-contrib-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["unit-test (18.19.0)", "unit-test (18)"]
  restrict_pushes = false
}

module "opentelemetry-js-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-js-contrib-repo.node_id
  pattern = "release-please--branches--main"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.opentelemetry-js-contrib-branch-protection-rule-0]
}

module "opentelemetry-js-contrib-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-js-contrib-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-js-contrib-branch-protection-rule-1]
}

module "opentelemetry-js-contrib-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-js-contrib-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.opentelemetry-js-contrib-branch-protection-rule-2]
}

