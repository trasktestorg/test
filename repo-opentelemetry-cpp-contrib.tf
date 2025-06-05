module "repo-opentelemetry-cpp-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-cpp-contrib"
  homepage_url = "https://opentelemetry.io/"
  has_discussions = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-cpp-contrib" {
  repository = "opentelemetry-cpp-contrib"

  team {
    team_id = github_team.cpp-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-contrib-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.cpp-maintainers.id
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

module "branch-protection-rule-opentelemetry-cpp-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-cpp-contrib.node_id
  pattern = "main"
  require_code_owner_reviews = false
  required_status_checks_strict = false
  restrict_pushes = false
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-cpp-contrib-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-cpp-contrib.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-cpp-contrib-0]
}

