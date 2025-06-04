module "repo-opentelemetry-proto" {
  source = "./modules/repository"
  name   = "opentelemetry-proto"
  description = "OpenTelemetry protocol (OTLP) specification and Protobuf definitions"
  homepage_url = "https://opentelemetry.io/docs/specs/otlp/"
  topics = [
    "opentelemetry",
  ]
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "opentelemetry-proto" {
  repository = "opentelemetry-proto"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.profiling-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.spec-sponsors.id
    permission = "push"
  }

  team {
    team_id = github_team.specs-triagers.id
    permission = "triage"
  }

  team {
    team_id = github_team.technical-committee.id
    permission = "maintain"
  }
}

module "branch-protection-rule-opentelemetry-proto-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-proto.node_id
  pattern = "main"
  required_approving_review_count = 2
  additional_required_status_checks = [
    "breaking-change",
    "gen-go",
    "gen-java",
    "gen-python",
  ]
  require_conversation_resolution = true
}

module "branch-protection-rule-opentelemetry-proto-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-proto.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-proto-0]
}

module "branch-protection-rule-opentelemetry-proto-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-proto.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-proto-1]
}

