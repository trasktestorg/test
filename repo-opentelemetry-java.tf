module "repo-opentelemetry-java" {
  source = "./modules/repository"
  name   = "opentelemetry-java"
  description = "OpenTelemetry Java SDK"
  topics = [
    "opentelemetry",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  has_pages = true
  pages_source_branch = "benchmarks"
}

resource "github_repository_collaborators" "opentelemetry-java" {
  repository = "opentelemetry-java"

  team {
    team_id = github_team.java-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.java-triagers.id
    permission = "triage"
  }

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

module "branch-protection-rule-opentelemetry-java-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java.node_id
  pattern = "main"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-java-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java.node_id
  pattern = "release/*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
  depends_on = [module.branch-protection-rule-opentelemetry-java-0]
}

