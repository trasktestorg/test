module "community-repo" {
  source = "../modules/repository"
  name   = "community"
  description = "OpenTelemetry community content"
  topics = [
    "cncf",
    "community",
    "opentelemetry"
  ]
  has_projects = true
  allow_auto_merge = true
}

module "community-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.community-repo.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  additional_required_status_checks = [
    "spelling-check",
    "table-check",
    "toc-check"
  ]
  require_conversation_resolution = true
  block_creations = true
}

module "community-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.community-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.community-branch-protection-rule-0]
}

module "community-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.community-repo.node_id
  pattern = "gh-readonly-queue/main/pr-*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.community-branch-protection-rule-1]
}

module "community-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.community-repo.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.community-branch-protection-rule-2]
}

