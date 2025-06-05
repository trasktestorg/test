module "repo-opamp-spec" {
  source = "./modules/repository"
  name   = "opamp-spec"
  description = "OpAMP Specification"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opamp-spec" {
  repository = "opamp-spec"

  team {
    team_id = github_team.opamp-spec-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.opamp-spec-maintainers.id
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

module "branch-protection-rule-opamp-spec-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opamp-spec.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "markdown-toc-check",
  ]
  required_linear_history = true
  block_creations = true
}

module "branch-protection-rule-opamp-spec-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opamp-spec.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opamp-spec-0]
}

module "branch-protection-rule-opamp-spec-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opamp-spec.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opamp-spec-1]
}

