module "repo-opentelemetry-js-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-js-contrib"
  description = "OpenTelemetry instrumentation for JavaScript modules"
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
}

resource "github_repository_collaborators" "opentelemetry-js-contrib" {
  repository = "opentelemetry-js-contrib"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.javascript-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.javascript-contrib-triagers.id
    permission = "triage"
  }

  team {
    team_id = github_team.javascript-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.javascript-triagers.id
    permission = "triage"
  }

  user {
    username = "dyladan"
    permission = "admin"
  }

  user {
    username = "pichlermarc"
    permission = "admin"
  }
}

module "branch-protection-rule-opentelemetry-js-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js-contrib.node_id
  pattern = "main"
  additional_required_status_checks = [
    "unit-test (18)",
    "unit-test (18.19.0)",
  ]
  restrict_pushes = false
}

module "branch-protection-rule-opentelemetry-js-contrib-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-js-contrib.node_id
  pattern = "release-please--branches--main"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-js-contrib-0]
}

module "branch-protection-rule-opentelemetry-js-contrib-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-js-contrib.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-js-contrib-1]
}

module "branch-protection-rule-opentelemetry-js-contrib-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-js-contrib.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-js-contrib-2]
}

