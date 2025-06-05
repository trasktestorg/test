module "repo-opentelemetry-go-vanityurls" {
  source = "./modules/repository"
  name   = "opentelemetry-go-vanityurls"
  description = "Vanityurls config for go.opentelemetry.io subdomain"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

resource "github_repository_collaborators" "opentelemetry-go-vanityurls" {
  repository = "opentelemetry-go-vanityurls"

  team {
    team_id = github_team.collector-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.go-maintainers.id
    permission = "admin"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  user {
    username = "punya"
    permission = "admin"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-go-vanityurls-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-go-vanityurls.node_id
  pattern = "main"
  required_status_checks_strict = false
}

module "branch-protection-rule-opentelemetry-go-vanityurls-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-go-vanityurls.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-go-vanityurls-0]
}

module "branch-protection-rule-opentelemetry-go-vanityurls-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-go-vanityurls.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-go-vanityurls-1]
}

