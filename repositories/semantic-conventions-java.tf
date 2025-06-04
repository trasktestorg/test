module "semantic-conventions-java-repo" {
  source = "../modules/repository"
  name   = "semantic-conventions-java"
  description = "Java generated classes for semantic conventions"
  homepage_url = ""
  has_projects = true
  allow_auto_merge = true
  vulnerability_alerts = false
}

module "semantic-conventions-java-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.semantic-conventions-java-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
}

module "semantic-conventions-java-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.semantic-conventions-java-repo.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "CodeQL",
    "gradle-wrapper-validation",
    "required-status-check",
  ]
  depends_on = [module.semantic-conventions-java-branch-protection-rule-0]
}

module "semantic-conventions-java-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.semantic-conventions-java-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.semantic-conventions-java-branch-protection-rule-1]
}

