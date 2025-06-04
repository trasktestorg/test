module "repo-opentelemetry-ebpf-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-ebpf-instrumentation"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "opentelemetry-ebpf-instrumentation" {
  repository = "opentelemetry-ebpf-instrumentation"

  team {
    team_id = github_team.ebpf-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.ebpf-instrumentation-maintainers.id
    permission = "maintain"
  }
}

module "branch-protection-rule-opentelemetry-ebpf-instrumentation-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ebpf-instrumentation.node_id
  pattern = "main"
  required_status_checks_strict = false
  block_creations = true
}

module "branch-protection-rule-opentelemetry-ebpf-instrumentation-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-ebpf-instrumentation.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-ebpf-instrumentation-0]
}

module "branch-protection-rule-opentelemetry-ebpf-instrumentation-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-ebpf-instrumentation.node_id
  pattern = "otelbot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-ebpf-instrumentation-1]
}

module "branch-protection-rule-opentelemetry-ebpf-instrumentation-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-ebpf-instrumentation.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  depends_on = [module.branch-protection-rule-opentelemetry-ebpf-instrumentation-2]
}

