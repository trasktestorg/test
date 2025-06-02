module "opentelemetry-sqlcommenter-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-sqlcommenter"
  description = "SQLCommenter components for various languages"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  has_pages = true
  pages_source_branch = "main"
  pages_path = "/docs"
}

module "opentelemetry-sqlcommenter-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-sqlcommenter-repo.node_id
  pattern = "main"
  block_creations = true
}

module "opentelemetry-sqlcommenter-branch-protection-rule-1" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-sqlcommenter-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-sqlcommenter-branch-protection-rule-0]
}

