module "repo-opamp-go" {
  source = "./modules/repository"
  name   = "opamp-go"
  description = "OpAMP protocol implementation in Go"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  allow_auto_merge = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opamp-go" {
  repository = "opamp-go"

  team {
    team_id = github_team.opamp-go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.opamp-go-maintainers.id
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

module "branch-protection-rule-opamp-go-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opamp-go.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "build-and-test",
  ]
  required_linear_history = true
  block_creations = true
}

module "branch-protection-rule-opamp-go-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opamp-go.node_id
  pattern = "renovate/**/**"
  enforce_admins = true
  depends_on = [module.branch-protection-rule-opamp-go-0]
}

module "branch-protection-rule-opamp-go-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opamp-go.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opamp-go-1]
}

