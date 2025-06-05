module "repo-sig-project-infra" {
  source = "./modules/repository"
  name   = "sig-project-infra"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "sig-project-infra" {
  repository = "sig-project-infra"

  team {
    team_id = github_team.sig-project-infra-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-project-infra-maintainers.id
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

module "branch-protection-rule-sig-project-infra-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-project-infra.node_id
  pattern = "main"
  required_status_checks_strict = false
  block_creations = true
}

module "branch-protection-rule-sig-project-infra-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-sig-project-infra.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-sig-project-infra-0]
}

module "branch-protection-rule-sig-project-infra-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-sig-project-infra.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-sig-project-infra-1]
}

