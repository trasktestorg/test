module "repo-opentelemetry-go-build-tools" {
  source = "./modules/repository"
  name   = "opentelemetry-go-build-tools"
  description = "Build tools for use by the Go API/SDK, the collector, and their associated contrib repositories"
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
}

module "branch-protection-rule-opentelemetry-go-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-build-tools.node_id
  pattern = "main"
  additional_required_status_checks = [
    "check-lint",
    "check-test-race",
  ]
  required_linear_history = true
}

module "branch-protection-rule-opentelemetry-go-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-build-tools.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-go-build-tools-0]
}

module "branch-protection-rule-opentelemetry-go-build-tools-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go-build-tools.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-build-tools-1]
}

