module "opentelemetry-php-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-php"
  description = "The OpenTelemetry PHP Library"
  homepage_url = "https://opentelemetry.io/docs/instrumentation/php/"
  topics = ["opentelemetry", "open-telemetry", "opentelemetry-php", "logging", "metrics", "php", "tracing"]
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  vulnerability_alerts = true
  has_pages = true
  pages_build_type = "workflow"
  pages_source_branch = "main"
  pages_path = "/docs"
}

module "opentelemetry-php-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-php-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
}

module "opentelemetry-php-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-php-repo.node_id
  pattern = "foo-2.x"
  pull_request_bypassers = ["open-telemetry/php-maintainers"]
  required_status_checks = false
  depends_on = [module.opentelemetry-php-branch-protection-rule-0]
}

