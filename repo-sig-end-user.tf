module "repo-sig-end-user" {
  source = "./modules/repository"
  name   = "sig-end-user"
  homepage_url = ""
  has_projects = true
}

module "branch-protection-rule-sig-end-user-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-sig-end-user.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
}

module "branch-protection-rule-sig-end-user-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-end-user.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.branch-protection-rule-sig-end-user-0]
}

