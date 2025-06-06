module "repo-opentelemetry-configuration" {
  source = "./modules/repository"
  name   = "opentelemetry-configuration"
  description = "JSON Schema definitions for OpenTelemetry declarative configuration"
  homepage_url = "https://opentelemetry.io/docs/specs/otel/configuration/#declarative-configuration"
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "opentelemetry-configuration" {
  repository = "opentelemetry-configuration"

  team {
    team_id = github_team.configuration-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.configuration-maintainers.id
    permission = "maintain"
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

module "branch-protection-rule-opentelemetry-configuration-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-configuration.node_id
  pattern = "main"
  additional_required_status_checks = [
    "check-schema",
  ]
}

module "branch-protection-rule-opentelemetry-configuration-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-configuration.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-configuration-0]
}

module "branch-protection-rule-opentelemetry-configuration-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-configuration.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-configuration-1]
}

