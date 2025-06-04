module "repo-stackoverflow2slack" {
  source = "./modules/repository"
  name   = "stackoverflow2slack"
  description = "A bot that republishing OTel-tagged questions from SO to Slack"
  homepage_url = ""
  has_wiki = true
  has_projects = true
  allow_merge_commit = true
  allow_rebase_merge = true
  delete_branch_on_merge = false
  vulnerability_alerts = false
}

resource "github_repository_collaborators" "stackoverflow2slack" {
  repository = "stackoverflow2slack"

  team {
    team_id = github_team.governance-committee.id
    permission = "push"
  }

  user {
    username = "austinlparker"
    permission = "admin"
  }
}

module "branch-protection-rule-stackoverflow2slack-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-stackoverflow2slack.node_id
  pattern = "main"
  block_creations = true
}

