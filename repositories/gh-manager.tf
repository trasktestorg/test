module "gh-manager-repo" {
  source = "../modules/repository"
  name   = "gh-manager"
  description = "This repository is for code to manage the OpenTelemetry GitHub Organization"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
}

module "gh-manager-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.gh-manager-repo.node_id
  pattern = "main"
  block_creations = true
}

