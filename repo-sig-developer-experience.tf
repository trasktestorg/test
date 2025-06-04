module "repo-sig-developer-experience" {
  source = "./modules/repository"
  name   = "sig-developer-experience"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
}

module "branch-protection-rule-sig-developer-experience-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-developer-experience.node_id
  pattern = "main"
  block_creations = true
}

