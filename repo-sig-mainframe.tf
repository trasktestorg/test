module "repo-sig-mainframe" {
  source = "./modules/repository"
  name   = "sig-mainframe"
  description = "Repository of the Mainframe SIG - Our aim is to enable OpenTelemetry for the Mainframe."
  homepage_url = ""
  has_projects = true
}

module "branch-protection-rule-sig-mainframe-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-sig-mainframe.node_id
  pattern = "main"
  block_creations = true
}

