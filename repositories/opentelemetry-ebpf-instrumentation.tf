module "opentelemetry-ebpf-instrumentation-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-ebpf-instrumentation"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

module "opentelemetry-ebpf-instrumentation-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-ebpf-instrumentation-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  block_creations = true
}

module "opentelemetry-ebpf-instrumentation-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-ebpf-instrumentation-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-ebpf-instrumentation-branch-protection-rule-0]
}

module "opentelemetry-ebpf-instrumentation-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-ebpf-instrumentation-repo.node_id
  pattern = "otelbot/**/*"
  depends_on = [module.opentelemetry-ebpf-instrumentation-branch-protection-rule-1]
}

module "opentelemetry-ebpf-instrumentation-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-ebpf-instrumentation-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  depends_on = [module.opentelemetry-ebpf-instrumentation-branch-protection-rule-2]
}

