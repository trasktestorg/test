module "repo-oteps" {
  source = "./modules/repository"
  name   = "oteps"
  description = "OpenTelemetry Enhancement Proposals"
  topics = ["opentelemetry"]
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_message = "PR_TITLE"
  archived = true
}

resource "github_repository_collaborators" "oteps" {
  repository = "oteps"

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

module "branch-protection-rule-oteps-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-oteps.node_id
  pattern = "main"
  required_approving_review_count = 4
  additional_required_status_checks = ["misspell", "markdownlint"]
  require_conversation_resolution = true
}

module "branch-protection-rule-oteps-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-oteps.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-oteps-0]
}

