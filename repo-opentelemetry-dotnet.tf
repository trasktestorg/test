module "repo-opentelemetry-dotnet" {
  source = "./modules/repository"
  name   = "opentelemetry-dotnet"
  description = "The OpenTelemetry .NET Client"
  topics = [
    "asp-net",
    "asp-net-core",
    "distributed-tracing",
    "ilogger",
    "iloggerprovider",
    "instrumentation-libraries",
    "logging",
    "metrics",
    "netcore",
    "opentelemetry",
    "otlp",
    "telemetry",
  ]
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  secret_scanning_status = "enabled"
}

module "branch-protection-rule-opentelemetry-dotnet-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-dotnet.node_id
  pattern = "main*"
  additional_required_status_checks = [
    "build-test",
  ]
  block_creations = true
  enforce_admins = false
}

module "branch-protection-rule-opentelemetry-dotnet-1" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-dotnet.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.branch-protection-rule-opentelemetry-dotnet-0]
}

