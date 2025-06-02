module "opentelemetry-erlang-contrib-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-erlang-contrib"
  description = "OpenTelemetry instrumentation for Erlang & Elixir"
  has_projects = true
  has_discussions = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
}

module "opentelemetry-erlang-contrib-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-erlang-contrib-repo.node_id
  pattern = "main"
  required_linear_history = true
  enforce_admins = false
}

module "opentelemetry-erlang-contrib-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-erlang-contrib-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-erlang-contrib-branch-protection-rule-0]
}

