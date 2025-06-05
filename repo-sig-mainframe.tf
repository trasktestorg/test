module "repo-sig-mainframe" {
  source = "./modules/repository"
  name   = "sig-mainframe"
  description = "Repository of the Mainframe SIG - Our aim is to enable OpenTelemetry for the Mainframe."
  homepage_url = ""
  has_projects = true
}

resource "github_repository_collaborators" "sig-mainframe" {
  repository = "sig-mainframe"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-mainframe-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-mainframe-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.sig-mainframe-triagers.id
    permission = "triage"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-sig-mainframe-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-mainframe.node_id
  pattern = "main"
  block_creations = true
}

