module "repo-opentelemetry-proto-java" {
  source = "./modules/repository"
  name   = "opentelemetry-proto-java"
  description = "Java Bindings for the OpenTelemetry Protocol (OTLP)"
  topics = [
    "opentelemetry",
  ]
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-proto-java" {
  repository = "opentelemetry-proto-java"

  team {
    team_id = github_team.java-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-instrumentation-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.java-maintainers.id
    permission = "admin"
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

module "branch-protection-rule-opentelemetry-proto-java-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-proto-java.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "Build",
    "CodeQL",
    "gradle-wrapper-validation",
  ]
  block_creations = true
}

module "branch-protection-rule-opentelemetry-proto-java-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-proto-java.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-proto-java-0]
}

module "branch-protection-rule-opentelemetry-proto-java-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-proto-java.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-proto-java-1]
}

