module "opentelemetry-network-build-tools-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-network-build-tools"
  description = "eBPF Collector Build Tools"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_BODY"
  allow_update_branch = true
  vulnerability_alerts = false
}

module "opentelemetry-network-build-tools-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-network-build-tools-repo.node_id
  pattern = "main"
  block_creations = true
}

module "opentelemetry-network-build-tools-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-network-build-tools-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.opentelemetry-network-build-tools-branch-protection-rule-0]
}

module "opentelemetry-network-build-tools-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-network-build-tools-repo.node_id
  pattern = "**/**"
  allows_deletion = true
  depends_on = [module.opentelemetry-network-build-tools-branch-protection-rule-1]
}

