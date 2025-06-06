module "repo-opentelemetry-sandbox-web-js" {
  source = "./modules/repository"
  name   = "opentelemetry-sandbox-web-js"
  description = "non-production level experimental Web JS packages"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_squash_merge = false
  allow_rebase_merge = true
  delete_branch_on_merge = false
  allow_auto_merge = true
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "opentelemetry-sandbox-web-js" {
  repository = "opentelemetry-sandbox-web-js"

  team {
    team_id = github_team.sandbox-web-js-maintainers.id
    permission = "maintain"
  }

  user {
    username = "martinkuba"
    permission = "admin"
  }

  user {
    username = "MSNev"
    permission = "admin"
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

module "branch-protection-rule-opentelemetry-sandbox-web-js-0" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-sandbox-web-js.node_id
  pattern = "**/**"
  additional_required_status_checks = [
    "node-tests (16)",
    "node-tests (18)",
    "node-tests (20)",
    "node-windows-tests (18)",
    "node-windows-tests (20)",
  ]
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
}

module "branch-protection-rule-opentelemetry-sandbox-web-js-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-sandbox-web-js.node_id
  pattern = "auto-merge/repo-staging"
  require_code_owner_reviews = false
  required_status_checks_strict = false
  require_conversation_resolution = true
  depends_on = [module.branch-protection-rule-opentelemetry-sandbox-web-js-0]
}

