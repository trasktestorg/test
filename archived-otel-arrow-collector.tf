module "repo-otel-arrow-collector" {
  source = "./modules/repository"
  name   = "otel-arrow-collector"
  description = "[DoNotUse] OpenTelemetry Collector with Apache Arrow support FORK OF OPENTELEMETRY COLLECTOR"
  homepage_url = "https://github.com/open-telemetry/otel-arrow"
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_BODY"
  delete_branch_on_merge = false
  archived = true
}

resource "github_repository_collaborators" "otel-arrow-collector" {
  repository = "otel-arrow-collector"

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-otel-arrow-collector-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-otel-arrow-collector.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_code_owner_reviews = false
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  restrict_pushes = true
  block_creations = true
}

