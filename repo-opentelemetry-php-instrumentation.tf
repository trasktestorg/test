module "repo-opentelemetry-php-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-php-instrumentation"
  description = "OpenTelemetry PHP auto-instrumentation extension"
  homepage_url = ""
  has_issues = false
  has_projects = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-php-instrumentation" {
  repository = "opentelemetry-php-instrumentation"

  team {
    team_id = github_team.php-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.php-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.php-triagers.id
    permission = "triage"
  }

  user {
    username = "bobstrecansky"
    permission = "admin"
  }

  user {
    username = "brettmc"
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

module "branch-protection-rule-opentelemetry-php-instrumentation-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-php-instrumentation.node_id
  pattern = "main"
  required_linear_history = true
  block_creations = true
}

