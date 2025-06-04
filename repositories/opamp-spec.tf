module "opamp-spec-repo" {
  source = "../modules/repository"
  name   = "opamp-spec"
  description = "OpAMP Specification"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

module "opamp-spec-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opamp-spec-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "markdown-toc-check",
  ]
  required_linear_history = true
  block_creations = true
}

module "opamp-spec-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opamp-spec-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opamp-spec-branch-protection-rule-0]
}

module "opamp-spec-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opamp-spec-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.opamp-spec-branch-protection-rule-1]
}

