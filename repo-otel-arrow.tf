module "repo-otel-arrow" {
  source = "./modules/repository"
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

resource "github_repository_collaborators" "otel-arrow" {
  repository = "otel-arrow"

  team {
    team_id = github_team.arrow-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.arrow-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.arrow-triagers.id
    permission = "triage"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }
}

module "branch-protection-rule-otel-arrow-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-otel-arrow.node_id
  pattern = "main"
  additional_required_status_checks = [
    "bench (otap-dataflow)",
    "clippy (otap-dataflow)",
    "deny (otap-dataflow)",
    "docs (otap-dataflow)",
    "fmt (otap-dataflow)",
    "gen_otelarrowcol",
    "markdownlint",
    "sanity",
    "structure_check (otap-dataflow)",
    "test_and_coverage (otap-dataflow)",
    "test_and_coverage (pkg/otel)",
  ]
  block_creations = true
}

module "branch-protection-rule-otel-arrow-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-otel-arrow.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-otel-arrow-0]
}

module "branch-protection-rule-otel-arrow-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-otel-arrow.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_code_owner_reviews = false
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-otel-arrow-1]
}

module "branch-protection-rule-otel-arrow-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-otel-arrow.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-otel-arrow-2]
}

