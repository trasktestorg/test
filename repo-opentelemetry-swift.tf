module "repo-opentelemetry-swift" {
  source = "./modules/repository"
  name   = "opentelemetry-swift"
  description = "OpenTelemetry API for Swift"
  homepage_url = "https://opentelemetry.io/docs/instrumentation/swift/"
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
}

resource "github_repository_collaborators" "opentelemetry-swift" {
  repository = "opentelemetry-swift"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.swift-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.swift-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.swift-triagers.id
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

module "branch-protection-rule-opentelemetry-swift-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-swift.node_id
  pattern = "main"
  require_code_owner_reviews = false
  additional_required_status_checks = [
    "iOS",
    "macOS",
  ]
}

module "branch-protection-rule-opentelemetry-swift-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-swift.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-swift-0]
}

