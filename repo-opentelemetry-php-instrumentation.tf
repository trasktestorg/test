module "repo-opentelemetry-php-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-php-instrumentation"
  description = "OpenTelemetry PHP auto-instrumentation extension"
  homepage_url = ""
  has_issues = false
  has_projects = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

module "branch-protection-rule-opentelemetry-php-instrumentation-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-php-instrumentation.node_id
  pattern = "main"
  required_linear_history = true
  block_creations = true
}

