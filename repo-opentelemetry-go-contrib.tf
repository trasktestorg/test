module "repo-opentelemetry-go-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-go-contrib"
  description = "Collection of extensions for OpenTelemetry-Go."
  homepage_url = "https://opentelemetry.io/"
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_update_branch = true
}

resource "github_repository_collaborators" "opentelemetry-go-contrib" {
  repository = "opentelemetry-go-contrib"

  team {
    team_id = github_team.go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.go-triagers.id
    permission = "triage"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }
}

module "branch-protection-rule-opentelemetry-go-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-contrib.node_id
  pattern = "main"
  additional_required_status_checks = [
    "changelog",
    "lint",
    "test-compatibility",
    "test-coverage",
    "test-race",
  ]
}

module "branch-protection-rule-opentelemetry-go-contrib-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-contrib.node_id
  pattern = "release-otelhttp-v0.35.1"
  restrict_dismissals = true
  required_status_checks_strict = false
  additional_required_status_checks = [
    "lint",
    "test-coverage",
    "test-race",
  ]
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-contrib-0]
}

module "branch-protection-rule-opentelemetry-go-contrib-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-contrib.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-contrib-1]
}

module "branch-protection-rule-opentelemetry-go-contrib-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-contrib.node_id
  pattern = "benchmarks"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-go-contrib-2]
}

module "branch-protection-rule-opentelemetry-go-contrib-4" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-contrib.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-contrib-3]
}

