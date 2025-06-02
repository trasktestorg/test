module "admin-repo" {
  source = "../modules/repository"
  name   = "admin"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  visibility = "private"
}

module "admin-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.admin-repo.node_id
  pattern = "main"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  block_creations = true
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

