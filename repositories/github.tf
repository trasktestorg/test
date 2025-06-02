module "github-repo" {
  source = "../modules/repository"
  name   = ".github"
  homepage_url = ""
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
}

module "github-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.github-repo.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  require_conversation_resolution = true
  block_creations = true
}

module "github-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.github-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.github-branch-protection-rule-0]
}

module "github-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.github-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.github-branch-protection-rule-1]
}

