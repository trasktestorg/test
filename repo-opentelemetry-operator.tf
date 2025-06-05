module "repo-opentelemetry-operator" {
  source = "./modules/repository"
  name   = "opentelemetry-operator"
  description = "Kubernetes Operator for OpenTelemetry Collector"
  homepage_url = ""
  topics = [
    "hacktoberfest",
    "kubernetes-operator",
    "opentelemetry",
    "opentelemetry-collector",
  ]
  allow_update_branch = true
  allow_auto_merge = true
}

resource "github_repository_collaborators" "opentelemetry-operator" {
  repository = "opentelemetry-operator"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.operator-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.operator-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.operator-ta-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.operator-triagers.id
    permission = "triage"
  }

  user {
    username = "openshift-ci-robot"
    permission = "pull"
  }

  user {
    username = "openshift-merge-robot"
    permission = "pull"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-operator-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-operator.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "Code standards (linting)",
    "CodeQL",
    "e2e-tests-check",
    "scorecard-tests-check",
    "Security",
    "Unit tests",
  ]
  block_creations = true
  allows_deletion = true
}

module "branch-protection-rule-opentelemetry-operator-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-operator.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-operator-0]
}

module "branch-protection-rule-opentelemetry-operator-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-operator.node_id
  pattern = "opentelemetrybot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-operator-1]
}

module "branch-protection-rule-opentelemetry-operator-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-operator.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-operator-2]
}

module "branch-protection-rule-opentelemetry-operator-4" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-operator.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_status_checks_strict = false
  restrict_pushes = true
  depends_on = [module.branch-protection-rule-opentelemetry-operator-3]
}

