module "repo-opentelemetry-erlang-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-erlang-contrib"
  description = "OpenTelemetry instrumentation for Erlang & Elixir"
  has_projects = true
  has_discussions = true
}

module "branch-protection-rule-opentelemetry-erlang-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-erlang-contrib.node_id
  pattern = "main"
  required_linear_history = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-erlang-contrib-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-erlang-contrib.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-erlang-contrib-0]
}

