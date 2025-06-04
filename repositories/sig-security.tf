module "sig-security-repo" {
  source = "../modules/repository"
  name   = "sig-security"
  homepage_url = ""
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "sig-security-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.sig-security-repo.node_id
  pattern = "main"
  additional_required_status_checks = [
    "markdownlint",
    "sanity",
  ]
  require_conversation_resolution = true
  required_linear_history = true
  block_creations = true
}

module "sig-security-branch-protection-rule-1" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.sig-security-repo.node_id
  pattern = "data-source"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  depends_on = [module.sig-security-branch-protection-rule-0]
}

module "sig-security-branch-protection-rule-2" {
  source = "../modules/branch-protection-feature"
  repository_id = module.sig-security-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.sig-security-branch-protection-rule-1]
}

module "sig-security-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.sig-security-repo.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.sig-security-branch-protection-rule-2]
}

