module "repo-prometheus-interoperability-spec" {
  source = "./modules/repository"
  name   = "prometheus-interoperability-spec"
  description = "Workgroup for building Prometheus-OTLP interoperability for the OTEL Collector and Prometheus related discussions."
  homepage_url = ""
  topics = ["prometheus", "k8s-deployment", "open-telemetry-collector"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
  archived = true
}

resource "github_repository_collaborators" "prometheus-interoperability-spec" {
  repository = "prometheus-interoperability-spec"

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

module "branch-protection-rule-prometheus-interoperability-spec-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-prometheus-interoperability-spec.node_id
  pattern = "main"
  require_code_owner_reviews = false
  required_status_checks = false
  enforce_admins = false
  block_creations = false
}

module "branch-protection-rule-prometheus-interoperability-spec-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-prometheus-interoperability-spec.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-prometheus-interoperability-spec-0]
}

