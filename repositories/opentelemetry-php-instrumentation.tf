module "opentelemetry-php-instrumentation-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-php-instrumentation"
  description = "OpenTelemetry PHP auto-instrumentation extension"
  homepage_url = ""
  has_issues = false
  has_projects = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

module "opentelemetry-php-instrumentation-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-php-instrumentation-repo.node_id
  pattern = "main"
  required_linear_history = true
  block_creations = true
}

