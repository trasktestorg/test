module "repo-opentelemetry-log-collection" {
  source = "./modules/repository"
  name   = "opentelemetry-log-collection"
  description = "OpenTelemetry log collection library"
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  archived = true
}

resource "github_repository_collaborators" "opentelemetry-log-collection" {
  repository = "opentelemetry-log-collection"

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

module "branch-protection-rule-opentelemetry-log-collection-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-log-collection.node_id
  pattern = "main"
  required_status_checks_strict = false
  block_creations = false
  additional_required_status_checks = ["lint"]
}

module "branch-protection-rule-opentelemetry-log-collection-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-log-collection.node_id
  pattern = "dependabot/**/**"
  allows_force_pushes = false
  allows_deletion = false
  depends_on = [module.branch-protection-rule-opentelemetry-log-collection-0]
}

module "branch-protection-rule-opentelemetry-log-collection-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-log-collection.node_id
  pattern = "**/**"
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-log-collection-1]
}

