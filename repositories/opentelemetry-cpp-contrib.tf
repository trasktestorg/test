module "opentelemetry-cpp-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-cpp-contrib"
  homepage_url = "https://opentelemetry.io/"
  has_discussions = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
}

module "opentelemetry-cpp-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-cpp-contrib-repo.node_id
  pattern = "main"
  require_code_owner_reviews = false
  required_status_checks_strict = false
  restrict_pushes = false
  enforce_admins = false
}

module "opentelemetry-cpp-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-cpp-contrib-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-cpp-contrib-branch-protection-rule-0]
}

