module "opentelemetry-java-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-java"
  description = "OpenTelemetry Java SDK"
  topics = ["opentelemetry"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  has_pages = true
  pages_source_branch = "benchmarks"
}

module "opentelemetry-java-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-repo.node_id
  pattern = "main"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
}

module "opentelemetry-java-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-repo.node_id
  pattern = "release/*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
  depends_on = [module.opentelemetry-java-branch-protection-rule-0]
}

