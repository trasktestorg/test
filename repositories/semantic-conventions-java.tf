module "semantic-conventions-java-repo" {
  source = "../modules/repository"
  name   = "semantic-conventions-java"
  description = "Java generated classes for semantic conventions"
  homepage_url = ""
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
}

module "semantic-conventions-java-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.semantic-conventions-java-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check", "gradle-wrapper-validation", "CodeQL"]
}

module "semantic-conventions-java-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.semantic-conventions-java-repo.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check", "gradle-wrapper-validation", "CodeQL"]
  depends_on = [module.semantic-conventions-java-branch-protection-rule-0]
}

module "semantic-conventions-java-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.semantic-conventions-java-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.semantic-conventions-java-branch-protection-rule-1]
}

