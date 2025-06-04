module "repo-opentelemetry-go-compile-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-go-compile-instrumentation"
  description = "TBD"
  homepage_url = ""
  has_projects = true
  has_discussions = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "branch-protection-rule-opentelemetry-go-compile-instrumentation-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go-compile-instrumentation.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
}

module "branch-protection-rule-opentelemetry-go-compile-instrumentation-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-compile-instrumentation.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-compile-instrumentation-0]
}

module "branch-protection-rule-opentelemetry-go-compile-instrumentation-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-compile-instrumentation.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-compile-instrumentation-1]
}

