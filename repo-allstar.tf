module "repo-allstar" {
  source = "./modules/repository"
  name   = ".allstar"
  description = "Enable and house Allstar policies centrally for the organizatio"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "allstar" {
  repository = ".allstar"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "maintain"
  }
}

module "branch-protection-rule-allstar-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-allstar.node_id
  pattern = "**/**"
  restrict_pushes = true
  block_creations = true
  allows_deletion = true
}

module "branch-protection-rule-allstar-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-allstar.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-allstar-0]
}

module "branch-protection-rule-allstar-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-allstar.node_id
  pattern = "main"
  block_creations = true
  depends_on = [module.branch-protection-rule-allstar-1]
}

