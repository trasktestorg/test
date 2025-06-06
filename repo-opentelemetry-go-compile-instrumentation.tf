module "repo-opentelemetry-go-compile-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-go-compile-instrumentation"
  description = "TBD"
  homepage_url = ""
  has_projects = true
  has_discussions = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

resource "github_repository_collaborators" "opentelemetry-go-compile-instrumentation" {
  repository = "opentelemetry-go-compile-instrumentation"

  team {
    team_id = github_team.go-compile-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-compile-instrumentation-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.go-compile-instrumentation-triagers.id
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

module "branch-protection-rule-opentelemetry-go-compile-instrumentation-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go-compile-instrumentation.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
}

module "branch-protection-rule-opentelemetry-go-compile-instrumentation-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-compile-instrumentation.node_id
  pattern = "main"
  depends_on = [module.branch-protection-rule-opentelemetry-go-compile-instrumentation-0]
}

module "branch-protection-rule-opentelemetry-go-compile-instrumentation-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-compile-instrumentation.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-compile-instrumentation-1]
}

