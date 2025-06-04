module "opentelemetry-go-instrumentation-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-go-instrumentation"
  description = "OpenTelemetry Auto Instrumentation using eBPF"
  topics = [
    "ebpf",
    "go",
    "golang",
    "instrumentation",
    "metrics",
    "observability",
    "telemetry",
    "tracing"
  ]
  has_wiki = true
  has_projects = true
  has_discussions = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

module "opentelemetry-go-instrumentation-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-go-instrumentation-repo.node_id
  pattern = "main"
  restrict_dismissals = true
  require_conversation_resolution = true
  block_creations = true
}

module "opentelemetry-go-instrumentation-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-go-instrumentation-repo.node_id
  pattern = "renovate/**"
  depends_on = [module.opentelemetry-go-instrumentation-branch-protection-rule-0]
}

module "opentelemetry-go-instrumentation-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-go-instrumentation-repo.node_id
  pattern = "automated/generated-offsets"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.opentelemetry-go-instrumentation-branch-protection-rule-1]
}

module "opentelemetry-go-instrumentation-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-go-instrumentation-repo.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.opentelemetry-go-instrumentation-branch-protection-rule-2]
}

