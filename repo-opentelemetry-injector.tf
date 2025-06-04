module "repo-opentelemetry-injector" {
  source = "./modules/repository"
  name   = "opentelemetry-injector"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "opentelemetry-injector" {
  repository = "opentelemetry-injector"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.injector-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.injector-maintainers.id
    permission = "maintain"
  }
}

module "branch-protection-rule-opentelemetry-injector-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-injector.node_id
  pattern = "main"
  block_creations = true
}

module "branch-protection-rule-opentelemetry-injector-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-injector.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-injector-0]
}

module "branch-protection-rule-opentelemetry-injector-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-injector.node_id
  pattern = "**/**"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  depends_on = [module.branch-protection-rule-opentelemetry-injector-1]
}

