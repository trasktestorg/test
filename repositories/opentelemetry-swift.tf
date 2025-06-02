module "opentelemetry-swift-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-swift"
  description = "OpenTelemetry API for Swift"
  homepage_url = "https://opentelemetry.io/docs/instrumentation/swift/"
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  vulnerability_alerts = true
}

module "opentelemetry-swift-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-swift-repo.node_id
  pattern = "main"
  require_code_owner_reviews = false
  additional_required_status_checks = ["macOS", "iOS"]
}

module "opentelemetry-swift-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-swift-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-swift-branch-protection-rule-0]
}

