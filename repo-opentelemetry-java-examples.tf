module "repo-opentelemetry-java-examples" {
  source = "./modules/repository"
  name   = "opentelemetry-java-examples"
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "branch-protection-rule-opentelemetry-java-examples-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-java-examples.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "gradle-wrapper-validation",
    "required-status-check",
  ]
  block_creations = true
}

module "branch-protection-rule-opentelemetry-java-examples-1" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-java-examples.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-java-examples-0]
}

