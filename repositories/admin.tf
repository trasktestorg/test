module "admin-repo" {
  source = "../modules/repository"
  name   = "admin"
  homepage_url = ""
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
  visibility = "private"
}

module "admin-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.admin-repo.node_id
  pattern = "main"
  # this is temporary to quickly keep the state file in sync with source control
  # while we are rolling this out initially, since otherwise its easy to accidentally
  # blow things away when they aren't in sync
  enforce_admins = false
  # EasyCLA is not running in merge queue on private repo
  # submitted EasyCLA ticket: https://jira.linuxfoundation.org/plugins/servlet/desk/portal/4/SUPPORT-35724
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  additional_required_status_checks = ["terraform"]
}

module "admin-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.admin-repo.node_id
  pattern = "pr/**/*"
  depends_on = [module.admin-branch-protection-rule-0]
}

module "admin-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.admin-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.admin-branch-protection-rule-1]
}

module "admin-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.admin-repo.node_id
  pattern = "**/**"
  depends_on = [module.admin-branch-protection-rule-2]
}

