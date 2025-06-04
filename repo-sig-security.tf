module "repo-sig-security" {
  source = "./modules/repository"
  name   = "sig-security"
  homepage_url = ""
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "branch-protection-rule-sig-security-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-security.node_id
  pattern = "main"
  additional_required_status_checks = [
    "markdownlint",
    "sanity",
  ]
  require_conversation_resolution = true
  required_linear_history = true
  block_creations = true
}

module "branch-protection-rule-sig-security-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-security.node_id
  pattern = "data-source"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  depends_on = [module.branch-protection-rule-sig-security-0]
}

module "branch-protection-rule-sig-security-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-sig-security.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-sig-security-1]
}

module "branch-protection-rule-sig-security-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-sig-security.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-sig-security-2]
}

