module "repo-opentelemetry-go" {
  source = "./modules/repository"
  name   = "opentelemetry-go"
  description = "OpenTelemetry Go API and SDK"
  homepage_url = "https://opentelemetry.io/docs/languages/go"
  topics = [
    "logging",
    "metrics",
    "opentelemetry",
    "tracing",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  allow_update_branch = true
}

resource "github_repository_collaborators" "opentelemetry-go" {
  repository = "opentelemetry-go"

  team {
    team_id = github_team.go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.go-triagers.id
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

module "branch-protection-rule-opentelemetry-go-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go.node_id
  pattern = "main"
  restrict_dismissals = true
  additional_required_status_checks = [
    "lint",
    "test-compatibility",
    "test-coverage",
    "test-race",
  ]
  require_conversation_resolution = true
}

module "branch-protection-rule-opentelemetry-go-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-0]
}

module "branch-protection-rule-opentelemetry-go-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-go-1]
}

module "branch-protection-rule-opentelemetry-go-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-2]
}

module "branch-protection-rule-opentelemetry-go-4" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-3]
}

