module "repo-opentelemetry-collector-builder" {
  source = "./modules/repository"
  name   = "opentelemetry-collector-builder"
  description = "A CLI tool that generates OpenTelemetry Collector binaries based on a manifest. "
  homepage_url = ""
  topics = ["opentelemetry", "opentelemetry-collector", "hacktoberfest"]
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
  archived = true
}

resource "github_repository_collaborators" "opentelemetry-collector-builder" {
  repository = "opentelemetry-collector-builder"

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

module "branch-protection-rule-opentelemetry-collector-builder-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector-builder.node_id
  pattern = "main"
  require_code_owner_reviews = false
  dismiss_stale_reviews = true
  block_creations = false
  additional_required_status_checks = ["Unit tests", "Security", "Integration test", "Code standards (linting)"]
}

module "branch-protection-rule-opentelemetry-collector-builder-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-collector-builder.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-builder-0]
}

