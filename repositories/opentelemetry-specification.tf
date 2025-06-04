module "opentelemetry-specification-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-specification"
  description = "Specifications for OpenTelemetry"
  topics = [
    "opentelemetry"
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  allow_update_branch = true
  allow_auto_merge = true
}

module "opentelemetry-specification-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-specification-repo.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  additional_required_status_checks = [
    "markdownlint",
    "misspell",
    "yamllint"
  ]
  require_conversation_resolution = true
}

module "opentelemetry-specification-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-specification-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-specification-branch-protection-rule-0]
}

module "opentelemetry-specification-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-specification-repo.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.opentelemetry-specification-branch-protection-rule-1]
}

