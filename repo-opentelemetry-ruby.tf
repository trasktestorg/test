module "repo-opentelemetry-ruby" {
  source = "./modules/repository"
  name   = "opentelemetry-ruby"
  description = "OpenTelemetry Ruby API & SDK, and related gems"
  homepage_url = "https://opentelemetry.io/"
  topics = [
    "distributed-tracing",
    "hacktoberfest",
    "metrics",
    "opentelemetry",
    "opentelemetry-api",
    "opentelemetry-ruby",
    "telemetry",
  ]
  has_projects = true
  has_discussions = true
  delete_branch_on_merge = false
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-ruby" {
  repository = "opentelemetry-ruby"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-maintainers.id
    permission = "admin"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-ruby-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ruby.node_id
  pattern = "main"
}

module "branch-protection-rule-opentelemetry-ruby-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-ruby.node_id
  pattern = "**/**"
  required_status_checks = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-ruby-0]
}

module "branch-protection-rule-opentelemetry-ruby-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ruby.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-ruby-1]
}

