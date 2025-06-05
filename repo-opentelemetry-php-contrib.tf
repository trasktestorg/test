module "repo-opentelemetry-php-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-php-contrib"
  description = "opentelemetry-php-contrib"
  has_issues = false
  delete_branch_on_merge = false
  secret_scanning_status = "enabled"
}

resource "github_repository_collaborators" "opentelemetry-php-contrib" {
  repository = "opentelemetry-php-contrib"

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

  user {
    username = "pdelewski"
    permission = "admin"
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

module "branch-protection-rule-opentelemetry-php-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-php-contrib.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
}

module "branch-protection-rule-opentelemetry-php-contrib-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-php-contrib.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-php-contrib-0]
}

module "branch-protection-rule-opentelemetry-php-contrib-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-php-contrib.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-php-contrib-1]
}

