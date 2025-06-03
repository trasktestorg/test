module "sig-project-infra-repo" {
  source = "../modules/repository"
  name   = "sig-project-infra"
  homepage_url = ""
  has_wiki = true
  has_projects = true
}

module "sig-project-infra-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.sig-project-infra-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  block_creations = true
}

module "sig-project-infra-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.sig-project-infra-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.sig-project-infra-branch-protection-rule-0]
}

module "sig-project-infra-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.sig-project-infra-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.sig-project-infra-branch-protection-rule-1]
}

