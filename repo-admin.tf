module "repo-admin" {
  source = "./modules/repository"
  name   = "admin"
  homepage_url = ""
  secret_scanning_status = "enabled"
  secret_scanning_push_protection_status = "enabled"
  visibility = "private"
}

resource "github_repository_collaborators" "admin" {
  repository = "admin"

  team {
    team_id = github_team.admins.id
    permission = "maintain"
  }

  team {
    team_id = github_team.android-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.arrow-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.assign-reviewers-action-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.collector-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.configuration-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.demo-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.docs-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-instrumentation-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.dotnet-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.ebpf-instrumentation-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.ebpf-profiler-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.erlang-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.erlang-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-compile-instrumentation-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-instrumentation-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.go-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.helm-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.injector-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-instrumentation-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.java-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.javascript-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.lambda-extension-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.network-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.opamp-go-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.opamp-spec-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.opentelemetry-python-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.operator-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.php-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.project-infra.id
    permission = "push"
  }

  team {
    team_id = github_team.proto-go-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.python-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-contrib-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.ruby-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.rust-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sandbox-web-js-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-contributor-experience-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-end-user-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-mainframe-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-project-infra-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.specs-semconv-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.sqlcommenter-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.swift-maintainers.id
    permission = "push"
  }

  team {
    team_id = github_team.technical-committee.id
    permission = "push"
  }

  team {
    team_id = github_team.weaver-maintainers.id
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

module "branch-protection-rule-admin-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-admin.node_id
  pattern = "main"
  # EasyCLA isn't supported on private repos
  # (https://jira.linuxfoundation.org/plugins/servlet/desk/portal/4/SUPPORT-35724)
  required_status_checks = false
  required_status_checks_no_easy_cla = true
  additional_required_status_checks = [
    "terraform",
  ]
}

module "branch-protection-rule-admin-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-admin.node_id
  pattern = "pr/**/*"
  depends_on = [module.branch-protection-rule-admin-0]
}

module "branch-protection-rule-admin-2" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-admin.node_id
  pattern = "renovate/**/*"
  depends_on = [module.branch-protection-rule-admin-1]
}

module "branch-protection-rule-admin-3" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-admin.node_id
  pattern = "**/**"
  depends_on = [module.branch-protection-rule-admin-2]
}

