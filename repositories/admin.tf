module "admin-repo" {
  source = "../modules/repository"
  name   = "admin"
  homepage_url = ""
  squash_merge_commit_message = "COMMIT_MESSAGES"
}

module "admin-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.admin-repo.node_id
  pattern = "main"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  additional_required_status_checks = ["terraform"]
}

module "admin-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.admin-repo.node_id
  pattern = "pr/**/*"
  depends_on = [module.admin-branch-protection-rule-0]
}

module "admin-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.admin-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.admin-branch-protection-rule-1]
}

module "admin-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.admin-repo.node_id
  pattern = "**/**"
  depends_on = [module.admin-branch-protection-rule-2]
}

