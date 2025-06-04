module "opentelemetry-operator-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-operator"
  description = "Kubernetes Operator for OpenTelemetry Collector"
  homepage_url = ""
  topics = [
    "hacktoberfest",
    "kubernetes-operator",
    "opentelemetry",
    "opentelemetry-collector"
  ]
  allow_update_branch = true
  allow_auto_merge = true
}

module "opentelemetry-operator-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-operator-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "Code standards (linting)",
    "CodeQL",
    "e2e-tests-check",
    "scorecard-tests-check",
    "Security",
    "Unit tests"
  ]
  block_creations = true
  allows_deletion = true
}

module "opentelemetry-operator-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-operator-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-operator-branch-protection-rule-0]
}

module "opentelemetry-operator-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-operator-repo.node_id
  pattern = "opentelemetrybot/**/**"
  depends_on = [module.opentelemetry-operator-branch-protection-rule-1]
}

module "opentelemetry-operator-branch-protection-rule-3" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-operator-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-operator-branch-protection-rule-2]
}

module "opentelemetry-operator-branch-protection-rule-4" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-operator-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_status_checks_strict = false
  restrict_pushes = true
  depends_on = [module.opentelemetry-operator-branch-protection-rule-3]
}

