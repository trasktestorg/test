module "repo-opentelemetry-dotnet" {
  source = "./modules/repository"
  name   = "opentelemetry-dotnet"
  description = "The OpenTelemetry .NET Client"
  topics = [
    "asp-net",
    "asp-net-core",
    "distributed-tracing",
    "ilogger",
    "iloggerprovider",
    "instrumentation-libraries",
    "logging",
    "metrics",
    "netcore",
    "opentelemetry",
    "otlp",
    "telemetry",
  ]
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  secret_scanning_status = "enabled"
}

resource "github_repository_collaborators" "opentelemetry-dotnet" {
  repository = "opentelemetry-dotnet"

  team {
    team_id = github_team.dotnet-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.dotnet-triagers.id
    permission = "triage"
  }

  user {
    username = "opentelemetrybot"
    permission = "push"
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

module "branch-protection-rule-opentelemetry-dotnet-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet.node_id
  pattern = "main*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-dotnet-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-dotnet.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-0]
}

