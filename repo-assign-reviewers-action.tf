module "repo-assign-reviewers-action" {
  source = "./modules/repository"
  name   = "assign-reviewers-action"
  description = "GitHub action to assign reviewers/approvers/etc based on configuration"
  homepage_url = ""
  has_projects = true
  delete_branch_on_merge = false
}

resource "github_repository_collaborators" "assign-reviewers-action" {
  repository = "assign-reviewers-action"

  team {
    team_id = github_team.assign-reviewers-action-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }
}

module "branch-protection-rule-assign-reviewers-action-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-assign-reviewers-action.node_id
  pattern = "main"
  block_creations = true
}

module "branch-protection-rule-assign-reviewers-action-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-assign-reviewers-action.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-assign-reviewers-action-0]
}

module "branch-protection-rule-assign-reviewers-action-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-assign-reviewers-action.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  enforce_admins = false
  depends_on = [module.branch-protection-rule-assign-reviewers-action-1]
}

