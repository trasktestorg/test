module "repo-opentelemetry-rust" {
  source = "./modules/repository"
  name   = "opentelemetry-rust"
  description = "The Rust OpenTelemetry implementation"
  topics = [
    "jaeger",
    "logging",
    "metrics",
    "opentelemetry",
    "prometheus",
    "tracing",
    "zipkin",
  ]
  has_projects = true
  has_discussions = true
  allow_rebase_merge = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_update_branch = true
  delete_branch_on_merge = false
}

module "branch-protection-rule-opentelemetry-rust-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-rust.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "docs",
    "lint",
    "test (stable, windows-latest)",
    "test (ubuntu-latest, stable)",
  ]
}

module "branch-protection-rule-opentelemetry-rust-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-rust.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-rust-0]
}

module "branch-protection-rule-opentelemetry-rust-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-rust.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-rust-1]
}

