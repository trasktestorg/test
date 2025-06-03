module "stackoverflow2slack-repo" {
  source = "../modules/repository"
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

module "stackoverflow2slack-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.stackoverflow2slack-repo.node_id
  pattern = "main"
  block_creations = true
}

