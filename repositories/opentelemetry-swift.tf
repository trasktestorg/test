module "opentelemetry-swift-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-swift"
  description = "OpenTelemetry API for Swift"
  homepage_url = "https://opentelemetry.io/docs/instrumentation/swift/"
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
}

module "opentelemetry-swift-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-swift-repo.node_id
  pattern = "main"
  require_code_owner_reviews = false
  additional_required_status_checks = [
    "iOS",
    "macOS",
  ]
}

module "opentelemetry-swift-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-swift-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-swift-branch-protection-rule-0]
}

