module "repo-gh-manager" {
  source = "./modules/repository"
  name   = "gh-manager"
  description = "This repository is for code to manage the OpenTelemetry GitHub Organization"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "gh-manager" {
  repository = "gh-manager"

  team {
    team_id = github_team.project-infra.id
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

module "branch-protection-rule-gh-manager-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-gh-manager.node_id
  pattern = "main"
}

