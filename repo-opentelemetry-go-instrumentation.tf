module "repo-opentelemetry-go-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-go-instrumentation"
  description = "OpenTelemetry Auto Instrumentation using eBPF"
  topics = [
    "ebpf",
    "go",
    "golang",
    "instrumentation",
    "metrics",
    "observability",
    "telemetry",
    "tracing",
  ]
  has_wiki = true
  has_projects = true
  has_discussions = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-go-instrumentation" {
  repository = "opentelemetry-go-instrumentation"

  team {
    team_id = github_team.go-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-instrumentation-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.go-instrumentation-triagers.id
    permission = "triage"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }
}

module "branch-protection-rule-opentelemetry-go-instrumentation-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-instrumentation.node_id
  pattern = "main"
  restrict_dismissals = true
  require_conversation_resolution = true
  block_creations = true
}

module "branch-protection-rule-opentelemetry-go-instrumentation-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-instrumentation.node_id
  pattern = "renovate/**"
  depends_on = [module.branch-protection-rule-opentelemetry-go-instrumentation-0]
}

module "branch-protection-rule-opentelemetry-go-instrumentation-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-instrumentation.node_id
  pattern = "automated/generated-offsets"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-instrumentation-1]
}

module "branch-protection-rule-opentelemetry-go-instrumentation-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go-instrumentation.node_id
  pattern = "**/**"
  required_status_checks_strict = false
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-instrumentation-2]
}

