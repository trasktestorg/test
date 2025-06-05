module "repo-opentelemetry-collector-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-collector-contrib"
  description = "Contrib repository for the OpenTelemetry Collector"
  topics = [
    "open-telemetry",
    "opentelemetry",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  allow_update_branch = true
  has_pages = true
  pages_source_branch = "benchmarks"
  pages_path = "/docs"
}

resource "github_repository_collaborators" "opentelemetry-collector-contrib" {
  repository = "opentelemetry-collector-contrib"

  team {
    team_id = github_team.collector-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-contrib-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.collector-contrib-triagers.id
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

module "branch-protection-rule-opentelemetry-collector-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector-contrib.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "changelog",
    "check-collector-module-version",
    "checks",
    "correctness-metrics",
    "correctness-traces",
    "integration-tests",
    "lint",
    "scoped-tests",
    "unittest",
    "windows-unittest",
  ]
  block_creations = true
}

module "branch-protection-rule-opentelemetry-collector-contrib-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-collector-contrib.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-collector-contrib-0]
}

module "branch-protection-rule-opentelemetry-collector-contrib-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-collector-contrib.node_id
  pattern = "dependabot/**/**"
  enforce_admins = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-contrib-1]
}

module "branch-protection-rule-opentelemetry-collector-contrib-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-collector-contrib.node_id
  pattern = "renovate/**/**"
  enforce_admins = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-contrib-2]
}

module "branch-protection-rule-opentelemetry-collector-contrib-4" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-collector-contrib.node_id
  pattern = "**/**"
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-collector-contrib-3]
}

