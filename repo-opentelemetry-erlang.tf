module "repo-opentelemetry-erlang" {
  source = "./modules/repository"
  name   = "opentelemetry-erlang"
  description = "OpenTelemetry Erlang SDK"
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_squash_merge = false
}

module "branch-protection-rule-opentelemetry-erlang-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-erlang.node_id
  pattern = "main"
  require_code_owner_reviews = false
  restrict_pushes = false
}

module "branch-protection-rule-opentelemetry-erlang-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-erlang.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-erlang-0]
}

