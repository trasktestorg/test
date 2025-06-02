module "opentelemetry-go-vanityurls-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-go-vanityurls"
  description = "Vanityurls config for go.opentelemetry.io subdomain"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  vulnerability_alerts = true
}

module "opentelemetry-go-vanityurls-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-go-vanityurls-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
}

module "opentelemetry-go-vanityurls-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-go-vanityurls-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-go-vanityurls-branch-protection-rule-0]
}

module "opentelemetry-go-vanityurls-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-go-vanityurls-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.opentelemetry-go-vanityurls-branch-protection-rule-1]
}

