module "opentelemetry-helm-charts-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-helm-charts"
  description = "OpenTelemetry Helm Charts"
  has_wiki = true
  has_projects = true
  allow_update_branch = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
  has_pages = true
}

module "opentelemetry-helm-charts-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-helm-charts-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "lint-test",
  ]
  required_linear_history = true
}

module "opentelemetry-helm-charts-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-helm-charts-repo.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.opentelemetry-helm-charts-branch-protection-rule-0]
}

module "opentelemetry-helm-charts-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-helm-charts-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.opentelemetry-helm-charts-branch-protection-rule-1]
}

module "opentelemetry-helm-charts-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-helm-charts-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-helm-charts-branch-protection-rule-2]
}

