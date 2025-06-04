module "weaver-repo" {
  source = "../modules/repository"
  name   = "weaver"
  description = "OTel Weaver lets you easily develop, validate, document, and deploy semantic conventions"
  homepage_url = ""
  topics = [
    "codegen",
    "documentation",
    "observability",
    "opentelemetry",
    "policy",
    "semconv"
  ]
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "weaver-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.weaver-repo.node_id
  pattern = "main"
  additional_required_status_checks = [
    "Check external types",
    "Check MSRV",
    "Clippy",
    "lockfile",
    "Rustfmt",
    "Spell Check with Typos",
    "Test (ubuntu-latest, stable)",
    "Validate workspace"
  ]
  block_creations = true
}

module "weaver-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.weaver-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.weaver-branch-protection-rule-0]
}

module "weaver-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.weaver-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.weaver-branch-protection-rule-1]
}

