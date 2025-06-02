module "opentelemetry-injector-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-injector"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
}

module "opentelemetry-injector-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-injector-repo.node_id
  pattern = "main"
  block_creations = true
}

module "opentelemetry-injector-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-injector-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-injector-branch-protection-rule-0]
}

module "opentelemetry-injector-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-injector-repo.node_id
  pattern = "**/**"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  depends_on = [module.opentelemetry-injector-branch-protection-rule-1]
}

