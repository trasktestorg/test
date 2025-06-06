module "repo-opentelemetry-js" {
  source = "./modules/repository"
  name   = "opentelemetry-js"
  description = "OpenTelemetry JavaScript Client"
  topics = [
    "api",
    "distributed-tracing",
    "metrics",
    "monitoring",
    "telemetry",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-js" {
  repository = "opentelemetry-js"

  team {
    team_id = github_team.javascript-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.javascript-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.javascript-triagers.id
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

module "branch-protection-rule-opentelemetry-js-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js.node_id
  pattern = "main"
  additional_required_status_checks = [
    "browser-tests",
    "node-tests (18)",
    "node-tests (20)",
    "node-tests (22)",
    "node-windows-tests",
    "webworker-tests",
  ]
  restrict_pushes = false
}

module "branch-protection-rule-opentelemetry-js-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  depends_on = [module.branch-protection-rule-opentelemetry-js-0]
  block_creations = false
}

module "branch-protection-rule-opentelemetry-js-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-js.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-js-1]
}

module "branch-protection-rule-opentelemetry-js-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-js.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  depends_on = [module.branch-protection-rule-opentelemetry-js-2]
}

