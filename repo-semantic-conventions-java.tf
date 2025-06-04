module "repo-semantic-conventions-java" {
  source = "./modules/repository"
  name   = "semantic-conventions-java"
  description = "Java generated classes for semantic conventions"
  homepage_url = ""
  has_projects = true
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "branch-protection-rule-semantic-conventions-java-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-semantic-conventions-java.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
}

module "branch-protection-rule-semantic-conventions-java-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-semantic-conventions-java.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
  depends_on = [module.branch-protection-rule-semantic-conventions-java-0]
}

module "branch-protection-rule-semantic-conventions-java-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-semantic-conventions-java.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-semantic-conventions-java-1]
}

