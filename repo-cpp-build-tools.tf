module "repo-cpp-build-tools" {
  source = "./modules/repository"
  name   = "cpp-build-tools"
  description = "Builds a docker image to make interacting with C++ projects easier."
  homepage_url = ""
  has_wiki = true
  has_projects = true
  delete_branch_on_merge = false
}

resource "github_repository_collaborators" "cpp-build-tools" {
  repository = "cpp-build-tools"

  team {
    team_id = github_team.cpp-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.cpp-maintainers.id
    permission = "maintain"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.governance-committee.id
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

module "branch-protection-rule-cpp-build-tools-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-cpp-build-tools.node_id
  pattern = "main"
  required_status_checks = false
  required_status_checks_no_easy_cla = true
}

module "branch-protection-rule-cpp-build-tools-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-cpp-build-tools.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-cpp-build-tools-0]
}

module "branch-protection-rule-cpp-build-tools-2" {
  source = "./modules/branch-protection-fallback"
  repository_id = module.repo-cpp-build-tools.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  require_conversation_resolution = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.branch-protection-rule-cpp-build-tools-1]
}

