module "repo-opamp-java" {
  source = "./modules/repository"
  name   = "opamp-java"
  description = "OpAMP protocol implementation in Java"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  archived = true
}

resource "github_repository_collaborators" "opamp-java" {
  repository = "opamp-java"

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

module "branch-protection-rule-opamp-java-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opamp-java.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_linear_history = true
}

module "branch-protection-rule-opamp-java-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opamp-java.node_id
  pattern = "main"
  require_code_owner_reviews = false
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
  required_linear_history = true
  restrict_pushes = false
  depends_on = [module.branch-protection-rule-opamp-java-0]
}

