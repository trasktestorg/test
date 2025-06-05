module "repo-opentelemetry-java-instrumentation" {
  source = "./modules/repository"
  name   = "opentelemetry-java-instrumentation"
  description = "OpenTelemetry auto-instrumentation and instrumentation libraries for Java"
  has_wiki = true
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-java-instrumentation" {
  repository = "opentelemetry-java-instrumentation"

  team {
    team_id = github_team.java-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-instrumentation-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.java-instrumentation-triagers.id
    permission = "triage"
  }

  user {
    username = "opentelemetrybot"
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

module "branch-protection-rule-opentelemetry-java-instrumentation-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-0]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "cloudfoundry"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-1]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "v0.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-2]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-4" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "v1.*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  lock_branch = true
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-3]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-5" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "gh-pages"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-4]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-6" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-5]
}

module "branch-protection-rule-opentelemetry-java-instrumentation-7" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-java-instrumentation.node_id
  pattern = "otelbot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-java-instrumentation-6]
}

