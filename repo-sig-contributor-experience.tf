module "repo-sig-contributor-experience" {
  source = "./modules/repository"
  name   = "sig-contributor-experience"
  description = "TODO"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_update_branch = true
  delete_branch_on_merge = false
  allow_auto_merge = true
}

module "branch-protection-rule-sig-contributor-experience-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-sig-contributor-experience.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_approving_review_count = 2
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
}

module "branch-protection-rule-sig-contributor-experience-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-contributor-experience.node_id
  pattern = "main"
  required_approving_review_count = 2
  require_conversation_resolution = true
  block_creations = true
  depends_on = [module.branch-protection-rule-sig-contributor-experience-0]
}

