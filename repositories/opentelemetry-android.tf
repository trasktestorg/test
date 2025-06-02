module "opentelemetry-android-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-android"
  description = "OpenTelemetry Tooling for Android"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  delete_branch_on_merge = false
}

module "opentelemetry-android-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check"]
  block_creations = true
}

module "opentelemetry-android-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-android-branch-protection-rule-0]
}

module "opentelemetry-android-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "renovate/**/**"
  depends_on = [module.opentelemetry-android-branch-protection-rule-1]
}

module "opentelemetry-android-branch-protection-rule-3" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = ["required-status-check"]
  depends_on = [module.opentelemetry-android-branch-protection-rule-2]
}

module "opentelemetry-android-branch-protection-rule-4" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "opentelemetrybot/**/*"
  depends_on = [module.opentelemetry-android-branch-protection-rule-3]
}

module "opentelemetry-android-branch-protection-rule-5" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "feature/**"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
  block_creations = true
  depends_on = [module.opentelemetry-android-branch-protection-rule-4]
}

module "opentelemetry-android-branch-protection-rule-6" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-android-repo.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.opentelemetry-android-branch-protection-rule-5]
}

