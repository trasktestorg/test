module "opentelemetry-rust-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-rust-contrib"
  description = "OpenTelemetry Contrib Packages for Rust"
  homepage_url = ""
  has_projects = true
  allow_rebase_merge = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
}

module "opentelemetry-rust-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-rust-contrib-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
}

module "opentelemetry-rust-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-rust-contrib-repo.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.opentelemetry-rust-contrib-branch-protection-rule-0]
}

