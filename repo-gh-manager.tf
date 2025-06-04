module "repo-gh-manager" {
  source = "./modules/repository"
  name   = "gh-manager"
  description = "This repository is for code to manage the OpenTelemetry GitHub Organization"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "gh-manager" {
  repository = "gh-manager"

  team {
    team_id = github_team.project-infra.id
    permission = "admin"
  }
}

module "branch-protection-rule-gh-manager-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-gh-manager.node_id
  pattern = "main"
  block_creations = true
}

