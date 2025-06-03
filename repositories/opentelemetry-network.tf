module "opentelemetry-network-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-network"
  description = "eBPF Collector"
  topics = ["ebpf", "open-telemetry", "opentelemetry"]
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

module "opentelemetry-network-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-network-repo.node_id
  pattern = "main"
  block_creations = true
}

module "opentelemetry-network-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-network-repo.node_id
  pattern = "renovate/**/*"
  depends_on = [module.opentelemetry-network-branch-protection-rule-0]
}

module "opentelemetry-network-branch-protection-rule-2" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.opentelemetry-network-repo.node_id
  pattern = "**/**"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.opentelemetry-network-branch-protection-rule-1]
}

