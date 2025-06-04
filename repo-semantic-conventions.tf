module "repo-semantic-conventions" {
  source = "./modules/repository"
  name   = "semantic-conventions"
  description = "Defines standards for generating consistent, accessible telemetry across a variety of domains"
  homepage_url = ""
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_auto_merge = true
  secret_scanning_status = "enabled"
}

resource "github_repository_collaborators" "semantic-conventions" {
  repository = "semantic-conventions"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.profiling-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-android-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-browser-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-cicd-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-client-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-code-attribute-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-container-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-db-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-dotnet-approver.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-feature-flag-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-genai-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-http-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-ios-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-jvm-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-k8s-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-log-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-messaging-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-mobile-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-sdk-health-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-security-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.semconv-system-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-mainframe-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.specs-semconv-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.specs-semconv-maintainers.id
    permission = "maintain"
  }

  team {
    team_id = github_team.technical-committee.id
    permission = "maintain"
  }

  team {
    team_id = github_team.weaver-approvers.id
    permission = "push"
  }
}

module "branch-protection-rule-semantic-conventions-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-semantic-conventions.node_id
  pattern = "main"
  required_approving_review_count = 2
  required_status_checks_strict = false
  additional_required_status_checks = [
    "areas-dropdown-check",
    "changelog",
    "markdown-toc-check",
    "markdownlint",
    "misspell",
    "polices-test",
    "policies-check",
    "schemas-check",
    "semantic-conventions",
    "semantic-conventions-registry",
    "yamllint",
  ]
  require_conversation_resolution = true
  block_creations = true
}

module "branch-protection-rule-semantic-conventions-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-semantic-conventions.node_id
  pattern = "gh-readonly-queue/main/pr-*"
  required_pull_request_reviews = false
  require_code_owner_reviews = false
  required_status_checks = false
  restrict_pushes = false
  enforce_admins = false
  allows_force_pushes = true
  allows_deletion = true
  depends_on = [module.branch-protection-rule-semantic-conventions-0]
}

module "branch-protection-rule-semantic-conventions-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-semantic-conventions.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-semantic-conventions-1]
}

module "branch-protection-rule-semantic-conventions-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-semantic-conventions.node_id
  pattern = "opentelemetrybot/**"
  depends_on = [module.branch-protection-rule-semantic-conventions-2]
}

module "branch-protection-rule-semantic-conventions-4" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-semantic-conventions.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  required_status_checks_strict = false
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-semantic-conventions-3]
}

