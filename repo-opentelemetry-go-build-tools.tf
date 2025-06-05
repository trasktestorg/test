module "repo-opentelemetry-go-build-tools" {
  source = "./modules/repository"
  name   = "opentelemetry-go-build-tools"
  description = "Build tools for use by the Go API/SDK, the collector, and their associated contrib repositories"
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
}

resource "github_repository_collaborators" "opentelemetry-go-build-tools" {
  repository = "opentelemetry-go-build-tools"

  team {
    team_id = github_team.collector-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-contrib-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.collector-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-maintainers.id
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

module "branch-protection-rule-opentelemetry-go-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-build-tools.node_id
  pattern = "main"
  additional_required_status_checks = [
    "check-lint",
    "check-test-race",
  ]
  required_linear_history = true
}

module "branch-protection-rule-opentelemetry-go-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-build-tools.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-go-build-tools-0]
}

module "branch-protection-rule-opentelemetry-go-build-tools-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go-build-tools.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-build-tools-1]
}

