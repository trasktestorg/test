module "repo-opentelemetry-ruby-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-ruby-contrib"
  description = "Contrib Packages for the OpenTelemetry Ruby API and SDK implementation."
  topics = [
    "cncf",
    "distributed-tracing",
    "opentelemetry",
    "opentelemetry-instrumentation",
    "ruby",
    "telemetry",
    "tracing",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  allow_update_branch = true
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-ruby-contrib" {
  repository = "opentelemetry-ruby-contrib"

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-contrib-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.ruby-maintainers.id
    permission = "maintain"
  }

  user {
    username = "arielvalentin"
    permission = "admin"
  }

  user {
    username = "mwear"
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

module "branch-protection-rule-opentelemetry-ruby-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ruby-contrib.node_id
  pattern = "main"
  additional_required_status_checks = [
    "all / ubuntu-latest",
    "Conventional Commits Validation",
  ]
  force_push_bypassers = ["/arielvalentin"]
}

module "branch-protection-rule-opentelemetry-ruby-contrib-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-ruby-contrib.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-ruby-contrib-0]
}

module "branch-protection-rule-opentelemetry-ruby-contrib-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ruby-contrib.node_id
  pattern = "release/**/*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-ruby-contrib-1]
}

module "branch-protection-rule-opentelemetry-ruby-contrib-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ruby-contrib.node_id
  pattern = "release-please*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-ruby-contrib-2]
}

module "branch-protection-rule-opentelemetry-ruby-contrib-4" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-ruby-contrib.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-ruby-contrib-3]
}

