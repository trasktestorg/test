module "repo-opentelemetry-erlang-api" {
  source = "./modules/repository"
  name   = "opentelemetry-erlang-api"
  description = "Erlang/Elixir OpenTelemetry API"
  homepage_url = ""
  topics = ["opentelemetry", "erlang", "elixir", "opentelemetry-erlang"]
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  archived = true
}

resource "github_repository_collaborators" "opentelemetry-erlang-api" {
  repository = "opentelemetry-erlang-api"

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

module "branch-protection-rule-opentelemetry-erlang-api-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-erlang-api.node_id
  pattern = "master"
}

module "branch-protection-rule-opentelemetry-erlang-api-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-erlang-api.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-erlang-api-0]
}

