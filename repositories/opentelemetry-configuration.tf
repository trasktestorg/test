module "opentelemetry-configuration-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-configuration"
  description = "JSON Schema definitions for OpenTelemetry declarative configuration"
  homepage_url = "https://opentelemetry.io/docs/specs/otel/configuration/#declarative-configuration"
  has_wiki = true
  has_projects = true
}

module "opentelemetry-configuration-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-configuration-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["check-schema"]
  block_creations = true
}

module "opentelemetry-configuration-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-configuration-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-configuration-branch-protection-rule-0]
}

module "opentelemetry-configuration-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-configuration-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.opentelemetry-configuration-branch-protection-rule-1]
}

