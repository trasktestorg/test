module "repo-opentelemetry-dotnet-contrib" {
  source = "./modules/repository"
  name   = "opentelemetry-dotnet-contrib"
  description = "This repository contains set of components extending functionality of the OpenTelemetry .NET SDK. Instrumentation libraries, exporters, and other components can find their home here."
  topics = [
    "dotnet",
    "dotnet-core",
    "opentelemetry",
  ]
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  secret_scanning_status = "enabled"
}

resource "github_repository_collaborators" "opentelemetry-dotnet-contrib" {
  repository = "opentelemetry-dotnet-contrib"

  team {
    team_id = github_team.dotnet-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-contrib-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.dotnet-contrib-triagers.id
    permission = "triage"
  }

  user {
    username = "opentelemetrybot"
    permission = "push"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-dotnet-contrib-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet-contrib.node_id
  pattern = "main*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-dotnet-contrib-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet-contrib.node_id
  pattern = "instrumentation*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  push_allowances = ["open-telemetry/dotnet-contrib-approvers"]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-contrib-0]
}

module "branch-protection-rule-opentelemetry-dotnet-contrib-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet-contrib.node_id
  pattern = "exporter*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  push_allowances = ["open-telemetry/dotnet-contrib-approvers"]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-contrib-1]
}

module "branch-protection-rule-opentelemetry-dotnet-contrib-3" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet-contrib.node_id
  pattern = "extensions*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  push_allowances = ["open-telemetry/dotnet-contrib-approvers"]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-contrib-2]
}

module "branch-protection-rule-opentelemetry-dotnet-contrib-4" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-dotnet-contrib.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-contrib-3]
}

