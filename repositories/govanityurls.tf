module "govanityurls-repo" {
  source = "../modules/repository"
  name   = "govanityurls"
  description = "Use a custom domain in your Go import path"
  homepage_url = ""
  has_issues = false
  has_projects = true
}

module "govanityurls-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.govanityurls-repo.node_id
  pattern = "main"
  restrict_pushes = false
}

module "govanityurls-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.govanityurls-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.govanityurls-branch-protection-rule-0]
}

module "govanityurls-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.govanityurls-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  depends_on = [module.govanityurls-branch-protection-rule-1]
}

