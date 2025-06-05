module "repo-govanityurls" {
  source = "./modules/repository"
  name   = "govanityurls"
  description = "Use a custom domain in your Go import path"
  homepage_url = ""
  has_issues = false
  has_projects = true
}

resource "github_repository_collaborators" "govanityurls" {
  repository = "govanityurls"

  team {
    team_id = github_team.collector-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-contrib-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.collector-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-instrumentation-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.go-maintainers.id
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

module "branch-protection-rule-govanityurls-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-govanityurls.node_id
  pattern = "main"
  restrict_pushes = false
}

module "branch-protection-rule-govanityurls-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-govanityurls.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-govanityurls-0]
}

module "branch-protection-rule-govanityurls-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-govanityurls.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  depends_on = [module.branch-protection-rule-govanityurls-1]
}

