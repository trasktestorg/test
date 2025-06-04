module "repo-opentelemetry-java-examples" {
  source = "./modules/repository"
  name   = "opentelemetry-java-examples"
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-java-examples" {
  repository = "opentelemetry-java-examples"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.java-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-contrib-maintainers.id
    permission = "admin"
  }

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

  team {
    team_id = github_team.java-maintainers.id
    permission = "admin"
  }

  user {
    username = "trasktest"
    permission = "push"
  }
}

module "branch-protection-rule-opentelemetry-java-examples-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-examples.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "gradle-wrapper-validation",
    "required-status-check",
  ]
  block_creations = true
}

module "branch-protection-rule-opentelemetry-java-examples-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-java-examples.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-java-examples-0]
}

