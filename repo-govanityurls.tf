module "repo-govanityurls" {
  source = "./modules/repository"
  name   = "govanityurls"
  description = "Use a custom domain in your Go import path"
  homepage_url = ""
  has_issues = false
  has_projects = true
}

module "branch-protection-rule-govanityurls-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-govanityurls.node_id
  pattern = "main"
  restrict_pushes = false
}

module "branch-protection-rule-govanityurls-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-govanityurls.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-govanityurls-0]
}

module "branch-protection-rule-govanityurls-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-govanityurls.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  depends_on = [module.branch-protection-rule-govanityurls-1]
}

