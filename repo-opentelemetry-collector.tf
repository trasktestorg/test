module "repo-opentelemetry-collector" {
  source = "./modules/repository"
  name   = "opentelemetry-collector"
  description = "OpenTelemetry Collector"
  topics = [
    "metrics",
    "monitoring",
    "observability",
    "open-telemetry",
    "opentelemetry",
    "telemetry",
  ]
  has_wiki = true
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_title = "PR_TITLE"
  merge_commit_message = "BLANK"
  allow_update_branch = true
  allow_auto_merge = true
}

resource "github_repository_collaborators" "opentelemetry-collector" {
  repository = "opentelemetry-collector"

  team {
    team_id = github_team.collector-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-maintainers.id
    permission = "OpenTelemetryMaintainer"
  }

  team {
    team_id = github_team.collector-triagers.id
    permission = "push"
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

module "branch-protection-rule-opentelemetry-collector-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "changelog",
    "Check",
    "checks",
    "contrib_tests",
    "lint",
    "unittest",
    "windows-unittest (windows-2022)",
    "windows-unittest (windows-2025)",
  ]
  block_creations = true
}

module "branch-protection-rule-opentelemetry-collector-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-collector.node_id
  pattern = "renovate/**/**"
  enforce_admins = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-0]
}

module "branch-protection-rule-opentelemetry-collector-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-collector.node_id
  pattern = "dependabot/**/**"
  enforce_admins = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-1]
}

module "branch-protection-rule-opentelemetry-collector-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector.node_id
  pattern = "gh-readonly-queue/main/**"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-2]
}

module "branch-protection-rule-opentelemetry-collector-4" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-collector.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-3]
}

