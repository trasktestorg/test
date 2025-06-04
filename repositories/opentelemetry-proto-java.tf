module "opentelemetry-proto-java-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-proto-java"
  description = "Java Bindings for the OpenTelemetry Protocol (OTLP)"
  topics = [
    "opentelemetry"
  ]
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "opentelemetry-proto-java-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-proto-java-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "Build",
    "CodeQL",
    "gradle-wrapper-validation"
  ]
  block_creations = true
}

module "opentelemetry-proto-java-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-proto-java-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-proto-java-branch-protection-rule-0]
}

module "opentelemetry-proto-java-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-proto-java-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-proto-java-branch-protection-rule-1]
}

