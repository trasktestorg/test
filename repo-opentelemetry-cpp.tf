module "repo-opentelemetry-cpp" {
  source = "./modules/repository"
  name   = "opentelemetry-cpp"
  description = "The OpenTelemetry C++ Client"
  homepage_url = "https://opentelemetry.io/"
  topics = [
    "api",
    "distributed-tracing",
    "metrics",
    "opentelemetry",
    "sdk",
    "telemetry",
  ]
  has_projects = true
  has_discussions = true
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-cpp" {
  repository = "opentelemetry-cpp"

  team {
    team_id = github_team.cpp-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }
}

module "branch-protection-rule-opentelemetry-cpp-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-cpp.node_id
  pattern = "main"
  additional_required_status_checks = [
    "Bazel",
    "Bazel on MacOS",
    "Bazel Windows",
    "DocFX check",
    "Format",
    "markdown-lint",
    "misspell",
  ]
  required_linear_history = true
}

module "branch-protection-rule-opentelemetry-cpp-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-cpp.node_id
  pattern = "async-changes"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-cpp-0]
}

