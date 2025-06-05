module "repo-opentelemetry-helm-charts" {
  source = "./modules/repository"
  name   = "opentelemetry-helm-charts"
  description = "OpenTelemetry Helm Charts"
  has_wiki = true
  has_projects = true
  allow_update_branch = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-helm-charts" {
  repository = "opentelemetry-helm-charts"

  team {
    team_id = github_team.helm-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.helm-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.helm-triagers.id
    permission = "triage"
  }

  user {
    username = "dmitryax"
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

module "branch-protection-rule-opentelemetry-helm-charts-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-helm-charts.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "lint-test",
  ]
  required_linear_history = true
}

module "branch-protection-rule-opentelemetry-helm-charts-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-helm-charts.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-helm-charts-0]
}

module "branch-protection-rule-opentelemetry-helm-charts-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-helm-charts.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-helm-charts-1]
}

module "branch-protection-rule-opentelemetry-helm-charts-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-helm-charts.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-helm-charts-2]
}

