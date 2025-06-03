module "semantic-conventions-repo" {
  source = "../modules/repository"
  name   = "semantic-conventions"
  description = "Defines standards for generating consistent, accessible telemetry across a variety of domains"
  homepage_url = ""
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  secret_scanning_status = "enabled"
}

module "semantic-conventions-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.semantic-conventions-repo.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  additional_required_status_checks = ["markdown-toc-check", "markdownlint", "misspell", "schemas-check", "semantic-conventions", "yamllint", "changelog", "areas-dropdown-check", "semantic-conventions-registry", "policies-check", "polices-test"]
  require_conversation_resolution = true
  block_creations = true
}

module "semantic-conventions-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.semantic-conventions-repo.node_id
  pattern = "gh-readonly-queue/main/pr-*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.semantic-conventions-branch-protection-rule-0]
}

module "semantic-conventions-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.semantic-conventions-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.semantic-conventions-branch-protection-rule-1]
}

module "semantic-conventions-branch-protection-rule-3" {
  source = "../modules/branch-protection-feature"
  repository_id = module.semantic-conventions-repo.node_id
  pattern = "opentelemetrybot/**"
  depends_on = [module.semantic-conventions-branch-protection-rule-2]
}

module "semantic-conventions-branch-protection-rule-4" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.semantic-conventions-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_status_checks_strict = false
  restrict_pushes = true
  block_creations = true
  depends_on = [module.semantic-conventions-branch-protection-rule-3]
}

