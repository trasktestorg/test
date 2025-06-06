module "repo-github" {
  source = "./modules/repository"
  name   = ".github"
  homepage_url = ""
  allow_update_branch = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "github" {
  repository = ".github"

  team {
    team_id = github_team.governance-committee.id
    permission = "maintain"
  }

  team {
    team_id = github_team.technical-committee.id
    permission = "maintain"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-github-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-github.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  require_conversation_resolution = true
}

module "branch-protection-rule-github-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-github.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-github-0]
}

module "branch-protection-rule-github-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-github.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-github-1]
}

