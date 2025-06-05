module "repo-opentelemetry-network" {
  source = "./modules/repository"
  name   = "opentelemetry-network"
  description = "eBPF Collector"
  topics = [
    "ebpf",
    "open-telemetry",
    "opentelemetry",
  ]
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-network" {
  repository = "opentelemetry-network"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

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
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-network-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-network.node_id
  pattern = "main"
  block_creations = true
}

module "branch-protection-rule-opentelemetry-network-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-network.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-network-0]
}

module "branch-protection-rule-opentelemetry-network-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-network.node_id
  pattern = "**/**"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-network-1]
}

