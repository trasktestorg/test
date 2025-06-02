module "otel-arrow-repo" {
  source = "../modules/repository"
  name   = "otel-arrow"
  description = "Protocol and libraries for sending and receiving OpenTelemetry data using Apache Arrow"
  homepage_url = ""
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_BODY"
  allow_update_branch = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "otel-arrow-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.otel-arrow-repo.node_id
  pattern = "main"
  additional_required_status_checks = ["markdownlint", "test_and_coverage (otap-dataflow)", "fmt (otap-dataflow)", "clippy (otap-dataflow)", "deny (otap-dataflow)", "structure_check (otap-dataflow)", "bench (otap-dataflow)", "docs (otap-dataflow)", "sanity", "test_and_coverage (pkg/otel)", "gen_otelarrowcol"]
  block_creations = true
}

module "otel-arrow-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.otel-arrow-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.otel-arrow-branch-protection-rule-0]
}

module "otel-arrow-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.otel-arrow-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_code_owner_reviews = false
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
  depends_on = [module.otel-arrow-branch-protection-rule-1]
}

module "otel-arrow-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.otel-arrow-repo.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.otel-arrow-branch-protection-rule-2]
}

