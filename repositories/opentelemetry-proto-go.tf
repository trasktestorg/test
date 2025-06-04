module "opentelemetry-proto-go-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-proto-go"
  description = "Generated code for OpenTelemetry protobuf data model"
  topics = [
    "otel",
    "protobuf",
  ]
  has_wiki = true
  has_projects = true
  allow_update_branch = true
}

module "opentelemetry-proto-go-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-proto-go-repo.node_id
  pattern = "main"
  additional_required_status_checks = [
    "generate-and-check",
    "test-compatibility",
  ]
}

module "opentelemetry-proto-go-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-proto-go-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-proto-go-branch-protection-rule-0]
}

module "opentelemetry-proto-go-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-proto-go-repo.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  enforce_admins = false
  depends_on = [module.opentelemetry-proto-go-branch-protection-rule-1]
}

