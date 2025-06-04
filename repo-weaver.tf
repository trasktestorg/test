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
  block_creations = true
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

