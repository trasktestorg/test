module "repo-community" {
  source = "./modules/repository"
  name   = "community"
  description = "OpenTelemetry community content"
  topics = [
    "cncf",
    "community",
    "opentelemetry",
  ]
  has_projects = true
  allow_auto_merge = true
}

resource "github_repository_collaborators" "community" {
  repository = "community"

  team {
    team_id = github_team.governance-committee.id
    permission = "admin"
  }

  team {
    team_id = github_team.technical-committee.id
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

module "branch-protection-rule-community-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-community.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  additional_required_status_checks = [
    "spelling-check",
    "table-check",
    "toc-check",
  ]
  require_conversation_resolution = true
}

module "branch-protection-rule-community-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-community.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-community-0]
}

module "branch-protection-rule-community-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-community.node_id
  pattern = "gh-readonly-queue/main/pr-*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-community-1]
  block_creations = false
}

module "branch-protection-rule-community-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-community.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-community-2]
}

