module "opentelemetry-java-examples-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-java-examples"
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
}

module "opentelemetry-java-examples-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-java-examples-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check", "gradle-wrapper-validation"]
  block_creations = true
}

module "opentelemetry-java-examples-branch-protection-rule-1" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-java-examples-repo.node_id
  pattern = "**/**"
  depends_on = [module.opentelemetry-java-examples-branch-protection-rule-0]
}

