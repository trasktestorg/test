module "repo-opentelemetry-demo" {
  source = "./modules/repository"
  name   = "opentelemetry-demo"
  description = "This repository contains the OpenTelemetry Astronomy Shop, a microservice-based distributed system intended to illustrate the implementation of OpenTelemetry in a near real-world environment."
  homepage_url = "https://opentelemetry.io/docs/demo/"
  topics = [
    "demo",
    "jaeger",
    "opentelemetry",
    "opentelemetry-collector",
    "opentelemetry-dotnet",
    "opentelemetry-erlang",
    "opentelemetry-go",
    "opentelemetry-java-agent",
    "opentelemetry-javascript",
    "opentelemetry-python",
    "opentelemetry-rust",
    "prometheus",
  ]
  has_projects = true
  has_discussions = true
  allow_update_branch = true
  secret_scanning_status = "enabled"
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-demo" {
  repository = "opentelemetry-demo"

  team {
    team_id = github_team.demo-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.demo-maintainers.id
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

module "branch-protection-rule-opentelemetry-demo-0" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-demo.node_id
  pattern = "renovate/*"
  restrict_pushes = true
  block_creations = true
  allows_force_pushes = false
}

module "branch-protection-rule-opentelemetry-demo-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-demo.node_id
  pattern = "main"
  additional_required_status_checks = [
    "markdownlint",
    "misspell",
    "sanity",
    "yamllint",
  ]
  require_conversation_resolution = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-demo-0]
}

module "branch-protection-rule-opentelemetry-demo-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-demo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-demo-1]
}

