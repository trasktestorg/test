module "opentelemetry-lambda-repo" {
  source = "../modules/repository"
  name   = "opentelemetry-lambda"
  description = "Create your own Lambda Layer in each OTel language using this starter code. Add the Lambda Layer to your Lambda Function to get tracing with OpenTelemetry."
  topics = ["aws-lambda", "opentelemetry"]
  has_projects = true
  has_discussions = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_message = "PR_TITLE"
  allow_update_branch = true
  allow_auto_merge = true
}

module "opentelemetry-lambda-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-lambda-repo.node_id
  pattern = "main"
  required_status_checks_strict = false
  required_linear_history = true
  block_creations = true
}

module "opentelemetry-lambda-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-lambda-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.opentelemetry-lambda-branch-protection-rule-0]
}

