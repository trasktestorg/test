module "repo-build-tools" {
  source = "./modules/repository"
  name   = "build-tools"
  description = "Building tools provided by OpenTelemetry"
  topics = [
    "opentelemetry",
  ]
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
}

resource "github_repository_collaborators" "build-tools" {
  repository = "build-tools"

  team {
    team_id = github_team.build-tools-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.spec-sponsors.id
    permission = "push"
  }

  team {
    team_id = github_team.technical-committee.id
    permission = "admin"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-build-tools.node_id
  pattern = "main"
  require_conversation_resolution = true
  block_creations = true
}

module "branch-protection-rule-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-build-tools.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-build-tools-0]
}

module "branch-protection-rule-build-tools-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-build-tools.node_id
  pattern = "feature/**"
  block_creations = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-build-tools-1]
}

module "branch-protection-rule-build-tools-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-build-tools.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-build-tools-2]
}

