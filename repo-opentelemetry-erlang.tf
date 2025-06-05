module "repo-opentelemetry-erlang" {
  source = "./modules/repository"
  name   = "opentelemetry-erlang"
  description = "OpenTelemetry Erlang SDK"
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_squash_merge = false
}

resource "github_repository_collaborators" "opentelemetry-erlang" {
  repository = "opentelemetry-erlang"

  team {
    team_id = github_team.erlang-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.erlang-maintainers.id
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

module "branch-protection-rule-opentelemetry-erlang-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-erlang.node_id
  pattern = "main"
  require_code_owner_reviews = false
  restrict_pushes = false
}

module "branch-protection-rule-opentelemetry-erlang-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-erlang.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-erlang-0]
}

