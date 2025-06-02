module "opentelemetry-ebpf-profiler-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-ebpf-profiler"
  description = "The production-scale datacenter profiler (C/C++, Go, Rust, Python, Java, NodeJS, .NET, PHP, Ruby, Perl, ...)"
  homepage_url = ""
  topics = ["ebpf", "profiler"]
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

module "opentelemetry-ebpf-profiler-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-ebpf-profiler-repo.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  block_creations = true
}

