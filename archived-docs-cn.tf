module "repo-docs-cn" {
  source = "./modules/repository"
  name   = "docs-cn"
  description = "OpenTelemetry 中文文档: 接入使用、技术标准、RFC、SDK等. "
  homepage_url = ""
  topics = ["opentelemetry", "markdown", "docs", "chinese"]
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_merge_commit = true
  allow_rebase_merge = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
  archived = true
}

resource "github_repository_collaborators" "docs-cn" {
  repository = "docs-cn"

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

module "branch-protection-rule-docs-cn-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-docs-cn.node_id
  pattern = "main"
  enforce_admins = false
}

module "branch-protection-rule-docs-cn-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-docs-cn.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-docs-cn-0]
}

