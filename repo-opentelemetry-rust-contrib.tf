module "repo-opentelemetry-rust-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-rust-contrib"
  description = "OpenTelemetry Contrib Packages for Rust"
  homepage_url = ""
  has_projects = true
  allow_rebase_merge = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_update_branch = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-rust-contrib" {
  repository = "opentelemetry-rust-contrib"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.rust-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.rust-maintainers.id
    permission = "OpenTelemetryMaintainer"
  }
}

module "branch-protection-rule-opentelemetry-rust-contrib-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-rust-contrib.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
}

module "branch-protection-rule-opentelemetry-rust-contrib-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-rust-contrib.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-rust-contrib-0]
}

