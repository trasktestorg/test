module "repo-opentelemetry-java-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-java-contrib"
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-java-contrib" {
  repository = "opentelemetry-java-contrib"

  team {
    team_id = github_team.java-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-contrib-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.java-contrib-triagers.id
    permission = "triage"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-java-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-contrib.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "gradle-wrapper-validation",
    "required-status-check",
  ]
}

module "branch-protection-rule-opentelemetry-java-contrib-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-contrib.node_id
  pattern = "release/*"
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
  depends_on = [module.branch-protection-rule-opentelemetry-java-contrib-0]
}

module "branch-protection-rule-opentelemetry-java-contrib-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-contrib.node_id
  pattern = "v0.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.branch-protection-rule-opentelemetry-java-contrib-1]
}

module "branch-protection-rule-opentelemetry-java-contrib-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-contrib.node_id
  pattern = "v1.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.branch-protection-rule-opentelemetry-java-contrib-2]
}

module "branch-protection-rule-opentelemetry-java-contrib-4" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-java-contrib.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-java-contrib-3]
}

module "branch-protection-rule-opentelemetry-java-contrib-5" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-java-contrib.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-java-contrib-4]
}

