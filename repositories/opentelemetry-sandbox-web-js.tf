module "opentelemetry-sandbox-web-js-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-sandbox-web-js"
  description = "non-production level experimental Web JS packages"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_squash_merge = false
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "opentelemetry-sandbox-web-js-branch-protection-rule-0" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-sandbox-web-js-repo.node_id
  pattern = "**/**"
  additional_required_status_checks = ["node-tests (16)", "node-tests (18)", "node-tests (20)", "node-windows-tests (18)", "node-windows-tests (20)"]
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
}

module "opentelemetry-sandbox-web-js-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-sandbox-web-js-repo.node_id
  pattern = "auto-merge/repo-staging"
  require_code_owner_reviews = false
  required_status_checks_strict = false
  require_conversation_resolution = true
  block_creations = true
  depends_on = [module.opentelemetry-sandbox-web-js-branch-protection-rule-0]
}

