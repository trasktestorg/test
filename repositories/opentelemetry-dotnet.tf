module "opentelemetry-dotnet-repo" {
  source = "../modules/repository"
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
    "telemetry"
  ]
  has_discussions = true
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  secret_scanning_status = "enabled"
}

module "opentelemetry-dotnet-branch-protection-rule-0" {
  source = "../modules/branch-protection-long-term"
  repository_id = module.opentelemetry-dotnet-repo.node_id
  pattern = "main*"
  additional_required_status_checks = [
    "build-test"
  ]
  block_creations = true
  enforce_admins = false
}

module "opentelemetry-dotnet-branch-protection-rule-1" {
  source = "../modules/branch-protection-feature"
  repository_id = module.opentelemetry-dotnet-repo.node_id
  pattern = "dependabot/**/*"
  depends_on = [module.opentelemetry-dotnet-branch-protection-rule-0]
}

