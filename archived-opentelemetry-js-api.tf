module "repo-opentelemetry-js-api" {
  source = "./modules/repository"
  name   = "opentelemetry-js-api"
  description = "OpenTelemetry Javascript API"
  topics = ["tracing", "observability", "opentelemetry", "opentelemetry-api", "cloud-native", "cncf"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  has_pages = true
  archived = true
}

resource "github_repository_collaborators" "opentelemetry-js-api" {
  repository = "opentelemetry-js-api"

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

module "branch-protection-rule-opentelemetry-js-api-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js-api.node_id
  pattern = "main"
  block_creations = false
}

module "branch-protection-rule-opentelemetry-js-api-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js-api.node_id
  pattern = "release-*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  depends_on = [module.branch-protection-rule-opentelemetry-js-api-0]
}

module "branch-protection-rule-opentelemetry-js-api-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-js-api.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-js-api-1]
}

module "branch-protection-rule-opentelemetry-js-api-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js-api.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-js-api-2]
}

