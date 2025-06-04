module "repo-cpp-build-tools" {
  source = "./modules/repository"
  name   = "cpp-build-tools"
  description = "Builds a docker image to make interacting with C++ projects easier."
  homepage_url = ""
  has_wiki = true
  has_projects = true
  delete_branch_on_merge = false
}

module "branch-protection-rule-cpp-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-cpp-build-tools.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  block_creations = true
}

module "branch-protection-rule-cpp-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-cpp-build-tools.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-cpp-build-tools-0]
}

module "branch-protection-rule-cpp-build-tools-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-cpp-build-tools.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-cpp-build-tools-1]
}

