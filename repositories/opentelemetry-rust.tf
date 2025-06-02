module "opentelemetry-rust-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-rust"
  description = "The Rust OpenTelemetry implementation"
  topics = ["opentelemetry", "tracing", "metrics", "logging", "jaeger", "prometheus", "zipkin"]
  has_projects = true
  has_discussions = true
  allow_rebase_merge = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
  delete_branch_on_merge = false
  vulnerability_alerts = true
}

module "opentelemetry-rust-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-rust-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["docs", "test (ubuntu-latest, stable)", "test (stable, windows-latest)", "lint"]
}

module "opentelemetry-rust-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-rust-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.opentelemetry-rust-branch-protection-rule-0]
}

module "opentelemetry-rust-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-rust-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-rust-branch-protection-rule-1]
}

