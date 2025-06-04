module "repo-opentelemetry-php-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-php-contrib"
  description = "opentelemetry-php-contrib"
  has_issues = false
  delete_branch_on_merge = false
  secret_scanning_status = "enabled"
}

module "branch-protection-rule-opentelemetry-php-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-php-contrib.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  required_status_checks_strict = false
}

module "branch-protection-rule-opentelemetry-php-contrib-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-php-contrib.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-php-contrib-0]
}

module "branch-protection-rule-opentelemetry-php-contrib-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-php-contrib.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-php-contrib-1]
}

