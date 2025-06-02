module "build-tools-repo" {
  source = "../modules/repository"
  name   = "build-tools"
  description = "Building tools provided by OpenTelemetry"
  topics = ["opentelemetry"]
  has_wiki = true
  has_projects = true
  squash_merge_commit_title = "PR_TITLE"
  merge_commit_message = "PR_TITLE"
  allow_auto_merge = true
}

module "build-tools-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.build-tools-repo.node_id
  pattern = "main"
  require_conversation_resolution = true
  block_creations = true
}

module "build-tools-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.build-tools-repo.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.build-tools-branch-protection-rule-0]
}

module "build-tools-branch-protection-rule-2" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.build-tools-repo.node_id
  pattern = "feature/**"
  block_creations = true
  allows_deletion = true
  depends_on = [module.build-tools-branch-protection-rule-1]
}

module "build-tools-branch-protection-rule-3" {
  source = "../modules/branch-protection-fallback"
  repository_id = module.build-tools-repo.node_id
  pattern = "**/**"
  required_pull_request_reviews = true
  restrict_pushes = true
  block_creations = true
  depends_on = [module.build-tools-branch-protection-rule-2]
}

