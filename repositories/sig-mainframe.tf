module "sig-mainframe-repo" {
  source = "../modules/repository"
  name   = "sig-mainframe"
  description = "Repository of the Mainframe SIG - Our aim is to enable OpenTelemetry for the Mainframe."
  homepage_url = ""
  has_projects = true
}

module "sig-mainframe-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.sig-mainframe-repo.node_id
  pattern = "main"
  block_creations = true
}

