module "allstar-repo" {
  source = "../modules/repository"
  name   = ".allstar"
  description = "Enable and house Allstar policies centrally for the organizatio"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  vulnerability_alerts = true
}

module "allstar-branch-protection-rule-0" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.allstar-repo.node_id
  pattern = "**/**"
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
}

module "allstar-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.allstar-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.allstar-branch-protection-rule-0]
}

module "allstar-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.allstar-repo.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.allstar-branch-protection-rule-1]
}

