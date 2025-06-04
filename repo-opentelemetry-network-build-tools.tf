module "repo-opentelemetry-network-build-tools" {
  source = "./modules/repository"
  name   = "opentelemetry-network-build-tools"
  description = "eBPF Collector Build Tools"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_BODY"
  allow_update_branch = true
  vulnerability_alerts = false
}

module "branch-protection-rule-opentelemetry-network-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-network-build-tools.node_id
  pattern = "main"
  block_creations = true
}

module "branch-protection-rule-opentelemetry-network-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-network-build-tools.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-network-build-tools-0]
}

module "branch-protection-rule-opentelemetry-network-build-tools-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-opentelemetry-network-build-tools.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-network-build-tools-1]
}

