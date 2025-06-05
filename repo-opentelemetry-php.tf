module "repo-opentelemetry-php" {
  source = "./modules/repository"
  name   = "opentelemetry-php"
  description = "The OpenTelemetry PHP Library"
  homepage_url = "https://opentelemetry.io/docs/instrumentation/php/"
  topics = [
    "logging",
    "metrics",
    "open-telemetry",
    "opentelemetry",
    "opentelemetry-php",
    "php",
    "tracing",
  ]
  has_wiki = true
  has_projects = true
  has_pages = true
  pages_build_type = "workflow"
  pages_source_branch = "main"
  pages_path = "/docs"
}

resource "github_repository_collaborators" "opentelemetry-php" {
  repository = "opentelemetry-php"

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

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
    permission = "push"
  }

  user {
    username = "bobstrecansky"
    permission = "admin"
  }

  user {
    username = "brettmc"
    permission = "admin"
  }

  user {
    username = "pdelewski"
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

module "branch-protection-rule-opentelemetry-php-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-php.node_id
  pattern = "main"
  required_status_checks_strict = false
}

module "branch-protection-rule-opentelemetry-php-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-php.node_id
  pattern = "foo-2.x"
  pull_request_bypassers = ["open-telemetry/php-maintainers"]
  required_status_checks = false
  depends_on = [module.branch-protection-rule-opentelemetry-php-0]
}

