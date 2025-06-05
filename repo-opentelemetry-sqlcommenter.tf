module "repo-opentelemetry-sqlcommenter" {
  source = "./modules/repository"
  name   = "opentelemetry-sqlcommenter"
  description = "SQLCommenter components for various languages"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
  has_pages = true
  pages_source_branch = "main"
  pages_path = "/docs"
}

resource "github_repository_collaborators" "opentelemetry-sqlcommenter" {
  repository = "opentelemetry-sqlcommenter"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.sqlcommenter-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sqlcommenter-maintainers.id
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

module "branch-protection-rule-opentelemetry-sqlcommenter-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-sqlcommenter.node_id
  pattern = "main"
  block_creations = true
}

module "branch-protection-rule-opentelemetry-sqlcommenter-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-sqlcommenter.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-sqlcommenter-0]
}

