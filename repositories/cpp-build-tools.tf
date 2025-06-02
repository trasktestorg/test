module "cpp-build-tools-repo" {
  source = "../modules/repository"
  name   = "cpp-build-tools"
  description = "Builds a docker image to make interacting with C++ projects easier."
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  vulnerability_alerts = true
}

module "cpp-build-tools-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.cpp-build-tools-repo.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  block_creations = true
}

module "cpp-build-tools-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.cpp-build-tools-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.cpp-build-tools-branch-protection-rule-0]
}

module "cpp-build-tools-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.cpp-build-tools-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.cpp-build-tools-branch-protection-rule-1]
}

