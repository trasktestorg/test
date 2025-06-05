module "repo-opentelemetry-erlang-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-erlang-contrib"
  description = "OpenTelemetry instrumentation for Erlang & Elixir"
  has_projects = true
  has_discussions = true
}

resource "github_repository_collaborators" "opentelemetry-erlang-contrib" {
  repository = "opentelemetry-erlang-contrib"

  team {
    team_id = github_team.erlang-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.erlang-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.erlang-contrib-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.erlang-maintainers.id
    permission = "maintain"
  }

  user {
    username = "tsloughter"
    permission = "admin"
  }

  user {
    username = "bryannaegele"
    permission = "admin"
  }

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

module "branch-protection-rule-opentelemetry-erlang-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-erlang-contrib.node_id
  pattern = "main"
  required_linear_history = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-erlang-contrib-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-erlang-contrib.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-erlang-contrib-0]
}

