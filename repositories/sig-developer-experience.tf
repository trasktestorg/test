module "sig-developer-experience-repo" {
  source = "../modules/repository"
  name   = "sig-developer-experience"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
}

module "sig-developer-experience-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.sig-developer-experience-repo.node_id
  pattern = "main"
  block_creations = true
}

