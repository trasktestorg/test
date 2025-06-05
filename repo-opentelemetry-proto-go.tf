module "repo-opentelemetry-proto-go" {
  source = "./modules/repository"
  name   = "opentelemetry-proto-go"
  description = "Generated code for OpenTelemetry protobuf data model"
  topics = [
    "otel",
    "protobuf",
  ]
  has_wiki = true
  has_projects = true
  allow_update_branch = true
}

resource "github_repository_collaborators" "opentelemetry-proto-go" {
  repository = "opentelemetry-proto-go"

  team {
    team_id = github_team.go-maintainers.id
    permission = "admin"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.proto-go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.proto-go-maintainers.id
    permission = "maintain"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-proto-go-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-proto-go.node_id
  pattern = "main"
  additional_required_status_checks = [
    "generate-and-check",
    "test-compatibility",
  ]
}

module "branch-protection-rule-opentelemetry-proto-go-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-proto-go.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-proto-go-0]
}

module "branch-protection-rule-opentelemetry-proto-go-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-proto-go.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-proto-go-1]
}

