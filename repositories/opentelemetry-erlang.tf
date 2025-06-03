module "opentelemetry-erlang-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-erlang"
  description = "OpenTelemetry Erlang SDK"
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_squash_merge = false
}

module "opentelemetry-erlang-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-erlang-repo.node_id
  pattern = "main"
  require_code_owner_reviews = false
  restrict_pushes = false
}

module "opentelemetry-erlang-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-erlang-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-erlang-branch-protection-rule-0]
}

