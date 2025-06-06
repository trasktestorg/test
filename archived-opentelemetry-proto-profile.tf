module "repo-opentelemetry-proto-profile" {
  source = "./modules/repository"
  name   = "opentelemetry-proto-profile"
  description = "A fork of OpenTelemetry protocol (OTLP) specification and Protobuf definitions for the Profiling WG"
  homepage_url = "https://opentelemetry.io/docs/specs/otlp/"
  has_wiki = true
  has_issues = false
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  archived = true
}

resource "github_repository_collaborators" "opentelemetry-proto-profile" {
  repository = "opentelemetry-proto-profile"

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

module "branch-protection-rule-opentelemetry-proto-profile-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-proto-profile.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  block_creations = false
}

