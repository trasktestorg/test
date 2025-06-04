module "opentelemetry-proto-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-proto"
  description = "OpenTelemetry protocol (OTLP) specification and Protobuf definitions"
  homepage_url = "https://opentelemetry.io/docs/specs/otlp/"
  topics = [
    "opentelemetry"
  ]
  has_wiki = true
  has_projects = true
}

module "opentelemetry-proto-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-proto-repo.node_id
  pattern = "main"
  required_approving_review_count = 2
  additional_required_status_checks = [
    "breaking-change",
    "gen-go",
    "gen-java",
    "gen-python"
  ]
  require_conversation_resolution = true
}

module "opentelemetry-proto-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-proto-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-proto-branch-protection-rule-0]
}

module "opentelemetry-proto-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-proto-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.opentelemetry-proto-branch-protection-rule-1]
}

