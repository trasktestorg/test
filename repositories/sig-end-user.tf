module "sig-end-user-repo" {
  source = "../modules/repository"
  name   = "sig-end-user"
  homepage_url = ""
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  vulnerability_alerts = true
}

module "sig-end-user-branch-protection-rule-0" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.sig-end-user-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
}

module "sig-end-user-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.sig-end-user-repo.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.sig-end-user-branch-protection-rule-0]
}

