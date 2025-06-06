module "repo-opentelemetry-network-build-tools" {
  source = "./modules/repository"
  name   = "opentelemetry-network-build-tools"
  description = "eBPF Collector Build Tools"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_BODY"
  allow_update_branch = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-network-build-tools" {
  repository = "opentelemetry-network-build-tools"

  team {
    team_id = github_team.network-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.network-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.network-triagers.id
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

module "branch-protection-rule-opentelemetry-network-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-network-build-tools.node_id
  pattern = "main"
}

module "branch-protection-rule-opentelemetry-network-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-network-build-tools.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-network-build-tools-0]
}

module "branch-protection-rule-opentelemetry-network-build-tools-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-network-build-tools.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-network-build-tools-1]
}

