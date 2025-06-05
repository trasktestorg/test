module "repo-opentelemetry-ebpf-profiler" {
  source = "./modules/repository"
  name   = "opentelemetry-ebpf-profiler"
  description = "The production-scale datacenter profiler (C/C++, Go, Rust, Python, Java, NodeJS, .NET, PHP, Ruby, Perl, ...)"
  homepage_url = ""
  topics = [
    "ebpf",
    "profiler",
  ]
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_update_branch = true
  allow_auto_merge = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

resource "github_repository_collaborators" "opentelemetry-ebpf-profiler" {
  repository = "opentelemetry-ebpf-profiler"

  team {
    team_id = github_team.ebpf-profiler-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.ebpf-profiler-maintainers.id
    permission = "OpenTelemetryMaintainer"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-ebpf-profiler-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-ebpf-profiler.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  block_creations = true
}

