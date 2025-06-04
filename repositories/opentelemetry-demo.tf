module "opentelemetry-demo-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-demo"
  description = "This repository contains the OpenTelemetry Astronomy Shop, a microservice-based distributed system intended to illustrate the implementation of OpenTelemetry in a near real-world environment."
  homepage_url = "https://opentelemetry.io/docs/demo/"
  topics = [
    "demo",
    "jaeger",
    "opentelemetry",
    "opentelemetry-collector",
    "opentelemetry-dotnet",
    "opentelemetry-erlang",
    "opentelemetry-go",
    "opentelemetry-java-agent",
    "opentelemetry-javascript",
    "opentelemetry-python",
    "opentelemetry-rust",
    "prometheus"
  ]
  has_projects = true
  has_discussions = true
  allow_update_branch = true
  secret_scanning_status = "enabled"
  vulnerability_alerts = false
}

module "opentelemetry-demo-branch-protection-rule-0" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-demo-repo.node_id
  pattern = "renovate/*"
  restrict_pushes = true
  block_creations = true
  allows_force_pushes = false
}

module "opentelemetry-demo-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-demo-repo.node_id
  pattern = "main"
  additional_required_status_checks = [
    "markdownlint",
    "misspell",
    "sanity",
    "yamllint"
  ]
  require_conversation_resolution = true
  block_creations = true
  depends_on = [module.opentelemetry-demo-branch-protection-rule-0]
}

module "opentelemetry-demo-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-demo-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-demo-branch-protection-rule-1]
}

