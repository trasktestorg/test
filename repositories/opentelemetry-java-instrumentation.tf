module "opentelemetry-java-instrumentation-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-java-instrumentation"
  description = "OpenTelemetry auto-instrumentation and instrumentation libraries for Java"
  has_wiki = true
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
  vulnerability_alerts = true
  secret_scanning_status = "enabled"
  has_pages = true
}

module "opentelemetry-java-instrumentation-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check", "CodeQL", "gradle-wrapper-validation"]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = ["gradle-wrapper-validation", "required-status-check", "CodeQL"]
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-0]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "cloudfoundry"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-1]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "v0.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-2]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-4" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "v1.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-3]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-5" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-4]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-6" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-5]
}

module "opentelemetry-java-instrumentation-branch-protection-rule-7" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-java-instrumentation-repo.node_id
  pattern = "otelbot/**/*"
  depends_on = [module.opentelemetry-java-instrumentation-branch-protection-rule-6]
}

