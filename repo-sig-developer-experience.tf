module "repo-sig-developer-experience" {
  source = "./modules/repository"
  name   = "sig-developer-experience"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
}

resource "github_repository_collaborators" "sig-developer-experience" {
  repository = "sig-developer-experience"

  team {
    team_id = github_team.sig-developer-experience-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-developer-experience-maintainers.id
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

module "branch-protection-rule-sig-developer-experience-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-developer-experience.node_id
  pattern = "main"
  block_creations = true
}

