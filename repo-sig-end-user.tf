module "repo-sig-end-user" {
  source = "./modules/repository"
  name   = "sig-end-user"
  homepage_url = ""
  has_projects = true
}

resource "github_repository_collaborators" "sig-end-user" {
  repository = "sig-end-user"

  team {
    team_id = github_team.sig-end-user-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-end-user-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.sig-end-user-triagers.id
    permission = "triage"
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

module "branch-protection-rule-sig-end-user-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-sig-end-user.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
}

module "branch-protection-rule-sig-end-user-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-end-user.node_id
  pattern = "main"
  depends_on = [module.branch-protection-rule-sig-end-user-0]
}

