module "repo-opamp-go" {
  source = "./modules/repository"
  name   = "opamp-go"
  description = "OpAMP protocol implementation in Go"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "branch-protection-rule-opamp-go-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opamp-go.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "build-and-test",
  ]
  required_linear_history = true
  block_creations = true
}

module "branch-protection-rule-opamp-go-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opamp-go.node_id
  pattern = "renovate/**/**"
  enforce_admins = true
  depends_on = [module.branch-protection-rule-opamp-go-0]
}

module "branch-protection-rule-opamp-go-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opamp-go.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opamp-go-1]
}

