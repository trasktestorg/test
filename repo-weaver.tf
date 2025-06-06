module "repo-weaver" {
  source = "./modules/repository"
  name   = "weaver"
  description = "OTel Weaver lets you easily develop, validate, document, and deploy semantic conventions"
  homepage_url = ""
  topics = [
    "codegen",
    "documentation",
    "observability",
    "opentelemetry",
    "policy",
    "semconv",
  ]
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_auto_merge = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "weaver" {
  repository = "weaver"

  team {
    team_id = github_team.specs-semconv-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.weaver-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.weaver-maintainers.id
    permission = "maintain"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-weaver-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-weaver.node_id
  pattern = "main"
  additional_required_status_checks = [
    "Check external types",
    "Check MSRV",
    "Clippy",
    "lockfile",
    "Rustfmt",
    "Spell Check with Typos",
    "Test (ubuntu-latest, stable)",
    "Validate workspace",
  ]
}

module "branch-protection-rule-weaver-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-weaver.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-weaver-0]
}

module "branch-protection-rule-weaver-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-weaver.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-weaver-1]
}

