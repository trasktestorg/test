module "repo-opentelemetry-io" {
  source = "./modules/repository"
  name   = "opentelemetry.io"
  description = "The OpenTelemetry website and documentation"
  topics = [
    "documentation",
    "opentelemetry",
  ]
  has_projects = true
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  allow_update_branch = true
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
}

resource "github_repository_collaborators" "opentelemetry-io" {
  repository = "opentelemetry.io"

  team {
    team_id = github_team.blog-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.demo-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.docs-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.docs-bn-approvers.id
    permission = "triage"
  }

  team {
    team_id = github_team.docs-es-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.docs-fr-approvers.id
    permission = "triage"
  }

  team {
    team_id = github_team.docs-ja-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.docs-maintainers.id
    permission = "admin"
  }

  team {
    team_id = github_team.docs-pt-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.docs-triagers.id
    permission = "triage"
  }

  team {
    team_id = github_team.docs-zh-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.erlang-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.helm-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-instrumentation-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.javascript-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.lambda-extension-approvers.id
    permission = "triage"
  }

  team {
    team_id = github_team.opamp-spec-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.operator-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.php-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.python-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-contrib-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.rust-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-contributor-experience-approvers.id
    permission = "triage"
  }

  team {
    team_id = github_team.sig-end-user-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.spec-sponsors.id
    permission = "push"
  }

  team {
    team_id = github_team.specs-semconv-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.swift-approvers.id
    permission = "push"
  }

  user {
    username = "opentelemetrybot"
    permission = "push"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }
}

module "branch-protection-rule-opentelemetry-io-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "main"
  additional_required_status_checks = [
    "BUILD and CHECK LINKS",
    "CSPELL page-local word list check",
    "EXPIRED FILE check",
    "FILE FORMAT",
    "FILENAME check",
    "I18N check",
    "MARKDOWN linter",
    "REFCACHE updates?",
    "SPELLING check",
    "WARNINGS in build log?",
  ]
  required_linear_history = true
  block_creations = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-io-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-io-0]
}

module "branch-protection-rule-opentelemetry-io-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "renovate/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-io-1]
}

module "branch-protection-rule-opentelemetry-io-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-io.node_id
  pattern = "opentelemetrybot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-io-2]
}

