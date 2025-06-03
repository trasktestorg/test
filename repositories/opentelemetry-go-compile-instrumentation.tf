module "opentelemetry-go-compile-instrumentation-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-go-compile-instrumentation"
  description = "TBD"
  homepage_url = ""
  has_projects = true
  has_discussions = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "opentelemetry-go-compile-instrumentation-branch-protection-rule-0" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-go-compile-instrumentation-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
}

module "opentelemetry-go-compile-instrumentation-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-go-compile-instrumentation-repo.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.opentelemetry-go-compile-instrumentation-branch-protection-rule-0]
}

module "opentelemetry-go-compile-instrumentation-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-go-compile-instrumentation-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-go-compile-instrumentation-branch-protection-rule-1]
}

