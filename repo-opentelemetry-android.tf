module "repo-opentelemetry-android" {
  source = "./modules/repository"
  name   = "opentelemetry-android"
  description = "OpenTelemetry Tooling for Android"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  delete_branch_on_merge = false
}

resource "github_repository_collaborators" "opentelemetry-android" {
  repository = "opentelemetry-android"

  team {
    team_id = github_team.android-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.android-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-android-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "main"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "required-status-check",
  ]
  block_creations = true
}

module "branch-protection-rule-opentelemetry-android-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-android-0]
}

module "branch-protection-rule-opentelemetry-android-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-android-1]
}

module "branch-protection-rule-opentelemetry-android-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "release/*"
  required_status_checks_strict = false
  additional_required_status_checks = [
    "required-status-check",
  ]
  depends_on = [module.branch-protection-rule-opentelemetry-android-2]
}

module "branch-protection-rule-opentelemetry-android-4" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "opentelemetrybot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-android-3]
}

module "branch-protection-rule-opentelemetry-android-5" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "feature/**"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
  block_creations = true
  depends_on = [module.branch-protection-rule-opentelemetry-android-4]
}

module "branch-protection-rule-opentelemetry-android-6" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-android.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-android-5]
}

