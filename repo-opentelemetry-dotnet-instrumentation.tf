module "repo-opentelemetry-dotnet-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-dotnet-instrumentation"
  description = "OpenTelemetry .NET Automatic Instrumentation"
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  allow_auto_merge = true
}

resource "github_repository_collaborators" "opentelemetry-dotnet-instrumentation" {
  repository = "opentelemetry-dotnet-instrumentation"

  team {
    team_id = github_team.dotnet-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-instrumentation-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.dotnet-instrumentation-triagers.id
    permission = "triage"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-dotnet-instrumentation-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet-instrumentation.node_id
  pattern = "main"
  additional_required_status_checks = [
    "check-native-format (macos-13-xlarge)",
    "check-native-format (ubuntu-22.04)",
    "check-native-format (windows-2022)",
    "check-native-headers",
    "check-sdk-versions",
    "test-jobs",
  ]
  required_linear_history = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-dotnet-instrumentation-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet-instrumentation.node_id
  pattern = "out-of-process-collection"
  required_approving_review_count = 0
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-instrumentation-0]
}

