module "repo-opentelemetry-python" {
  source = "./modules/repository"
  name   = "opentelemetry-python"
  description = "OpenTelemetry Python API and SDK "
  topics = [
    "correlationcontext",
    "distributed-tracing",
    "logging",
    "metrics",
    "opentelemetry",
    "python",
    "sdk",
    "tracecontext",
  ]
  has_wiki = true
  has_projects = true
  has_discussions = true
  allow_auto_merge = true
  has_pages = true
}

resource "github_repository_collaborators" "opentelemetry-python" {
  repository = "opentelemetry-python"

  team {
    team_id = github_team.python-approvers.id
    permission = "push"
  }

  team {
    team_id = github_team.python-maintainers.id
    permission = "admin"
  }

  # this is really an org-level role, but it needs to be specified here
  # to avoid false positives showing up in the plan
  # (see underlying bug at https://github.com/integrations/terraform-provider-github/issues/2445)
  team {
    team_id = github_team.sig-security-maintainers.id
    permission = "pull"
  }
}

module "branch-protection-rule-opentelemetry-python-0" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-python.node_id
  pattern = "main"
  require_code_owner_reviews = false
  additional_required_status_checks = [
    "contrib_0 / distro",
    "contrib_0 / exporter-prometheus-remote-write",
    "contrib_0 / exporter-richconsole",
    "contrib_0 / instrumentation-aio-pika-0",
    "contrib_0 / instrumentation-aio-pika-1",
    "contrib_0 / instrumentation-aio-pika-2",
    "contrib_0 / instrumentation-aio-pika-3",
    "contrib_0 / instrumentation-aiohttp-client",
    "contrib_0 / instrumentation-aiohttp-server",
    "contrib_0 / instrumentation-aiokafka",
    "contrib_0 / instrumentation-aiopg",
    "contrib_0 / instrumentation-asgi",
    "contrib_0 / instrumentation-asyncio",
    "contrib_0 / instrumentation-asyncpg",
    "contrib_0 / instrumentation-aws-lambda",
    "contrib_0 / instrumentation-boto",
    "contrib_0 / instrumentation-boto3sqs",
    "contrib_0 / instrumentation-botocore-0",
    "contrib_0 / instrumentation-botocore-1",
    "contrib_0 / instrumentation-cassandra",
    "contrib_0 / instrumentation-celery",
    "contrib_0 / instrumentation-confluent-kafka",
    "contrib_0 / instrumentation-dbapi",
    "contrib_0 / instrumentation-django-0",
    "contrib_0 / instrumentation-django-1",
    "contrib_0 / instrumentation-django-2",
    "contrib_0 / instrumentation-elasticsearch-0",
    "contrib_0 / instrumentation-elasticsearch-1",
    "contrib_0 / instrumentation-elasticsearch-2",
    "contrib_0 / instrumentation-falcon-0",
    "contrib_0 / instrumentation-falcon-1",
    "contrib_0 / instrumentation-falcon-2",
    "contrib_0 / instrumentation-fastapi",
    "contrib_0 / instrumentation-flask-0",
    "contrib_0 / instrumentation-flask-1",
    "contrib_0 / instrumentation-flask-2",
    "contrib_0 / instrumentation-grpc-0",
    "contrib_0 / instrumentation-grpc-1",
    "contrib_0 / instrumentation-httpx-0",
    "contrib_0 / instrumentation-httpx-1",
    "contrib_0 / instrumentation-jinja2",
    "contrib_0 / instrumentation-kafka-python",
    "contrib_0 / instrumentation-kafka-pythonng",
    "contrib_0 / instrumentation-logging",
    "contrib_0 / instrumentation-mysql-0",
    "contrib_0 / instrumentation-mysql-1",
    "contrib_0 / instrumentation-mysqlclient",
    "contrib_0 / instrumentation-psycopg",
    "contrib_0 / instrumentation-psycopg2",
    "contrib_0 / instrumentation-pymemcache-0",
    "contrib_0 / instrumentation-pymemcache-1",
    "contrib_0 / instrumentation-pymemcache-2",
    "contrib_0 / instrumentation-pymemcache-3",
    "contrib_0 / instrumentation-pymemcache-4",
    "contrib_0 / instrumentation-pymongo",
    "contrib_0 / instrumentation-pymysql",
    "contrib_0 / instrumentation-pyramid",
    "contrib_0 / instrumentation-redis",
    "contrib_0 / instrumentation-remoulade",
    "contrib_0 / instrumentation-requests",
    "contrib_0 / instrumentation-sio-pika-0",
    "contrib_0 / instrumentation-sio-pika-1",
    "contrib_0 / instrumentation-sqlalchemy-1",
    "contrib_0 / instrumentation-sqlalchemy-2",
    "contrib_0 / instrumentation-sqlite3",
    "contrib_0 / instrumentation-starlette-latest",
    "contrib_0 / instrumentation-starlette-oldest",
    "contrib_0 / instrumentation-system-metrics",
    "contrib_0 / instrumentation-threading",
    "contrib_0 / instrumentation-tornado",
    "contrib_0 / instrumentation-tortoiseorm",
    "contrib_0 / instrumentation-urllib",
    "contrib_0 / instrumentation-urllib3-0",
    "contrib_0 / instrumentation-urllib3-1",
    "contrib_0 / instrumentation-wsgi",
    "contrib_0 / opentelemetry-instrumentation",
    "contrib_0 / processor-baggage",
    "contrib_0 / propagator-ot-trace",
    "contrib_0 / resource-detector-containerid",
    "contrib_0 / util-http",
    "docs",
    "generate-workflows",
    "opentelemetry-api",
    "opentelemetry-api 3.10 Ubuntu",
    "opentelemetry-api 3.10 Windows",
    "opentelemetry-api 3.11 Ubuntu",
    "opentelemetry-api 3.11 Windows",
    "opentelemetry-api 3.12 Ubuntu",
    "opentelemetry-api 3.12 Windows",
    "opentelemetry-api 3.9 Ubuntu",
    "opentelemetry-api 3.9 Windows",
    "opentelemetry-exporter-opencensus",
    "opentelemetry-exporter-opencensus 3.10 Ubuntu",
    "opentelemetry-exporter-opencensus 3.10 Windows",
    "opentelemetry-exporter-opencensus 3.11 Ubuntu",
    "opentelemetry-exporter-opencensus 3.11 Windows",
    "opentelemetry-exporter-opencensus 3.12 Ubuntu",
    "opentelemetry-exporter-opencensus 3.12 Windows",
    "opentelemetry-exporter-opencensus 3.9 Ubuntu",
    "opentelemetry-exporter-opencensus 3.9 Windows",
    "opentelemetry-exporter-otlp-combined",
    "opentelemetry-exporter-otlp-combined 3.10 Ubuntu",
    "opentelemetry-exporter-otlp-combined 3.10 Windows",
    "opentelemetry-exporter-otlp-combined 3.11 Ubuntu",
    "opentelemetry-exporter-otlp-combined 3.11 Windows",
    "opentelemetry-exporter-otlp-combined 3.12 Ubuntu",
    "opentelemetry-exporter-otlp-combined 3.12 Windows",
    "opentelemetry-exporter-otlp-combined 3.9 Ubuntu",
    "opentelemetry-exporter-otlp-combined 3.9 Windows",
    "opentelemetry-exporter-otlp-proto-common",
    "opentelemetry-exporter-otlp-proto-grpc",
    "opentelemetry-exporter-otlp-proto-http",
    "opentelemetry-exporter-prometheus",
    "opentelemetry-exporter-prometheus 3.10 Ubuntu",
    "opentelemetry-exporter-prometheus 3.10 Windows",
    "opentelemetry-exporter-prometheus 3.11 Ubuntu",
    "opentelemetry-exporter-prometheus 3.11 Windows",
    "opentelemetry-exporter-prometheus 3.12 Ubuntu",
    "opentelemetry-exporter-prometheus 3.12 Windows",
    "opentelemetry-exporter-prometheus 3.9 Ubuntu",
    "opentelemetry-exporter-prometheus 3.9 Windows",
    "opentelemetry-exporter-zipkin-combined",
    "opentelemetry-exporter-zipkin-combined 3.10 Ubuntu",
    "opentelemetry-exporter-zipkin-combined 3.10 Windows",
    "opentelemetry-exporter-zipkin-combined 3.11 Ubuntu",
    "opentelemetry-exporter-zipkin-combined 3.11 Windows",
    "opentelemetry-exporter-zipkin-combined 3.12 Ubuntu",
    "opentelemetry-exporter-zipkin-combined 3.12 Windows",
    "opentelemetry-exporter-zipkin-combined 3.9 Ubuntu",
    "opentelemetry-exporter-zipkin-combined 3.9 Windows",
    "opentelemetry-exporter-zipkin-json",
    "opentelemetry-exporter-zipkin-json 3.10 Ubuntu",
    "opentelemetry-exporter-zipkin-json 3.10 Windows",
    "opentelemetry-exporter-zipkin-json 3.11 Ubuntu",
    "opentelemetry-exporter-zipkin-json 3.11 Windows",
    "opentelemetry-exporter-zipkin-json 3.12 Ubuntu",
    "opentelemetry-exporter-zipkin-json 3.12 Windows",
    "opentelemetry-exporter-zipkin-json 3.9 Ubuntu",
    "opentelemetry-exporter-zipkin-json 3.9 Windows",
    "opentelemetry-exporter-zipkin-proto-http",
    "opentelemetry-exporter-zipkin-proto-http 3.10 Ubuntu",
    "opentelemetry-exporter-zipkin-proto-http 3.10 Windows",
    "opentelemetry-exporter-zipkin-proto-http 3.11 Ubuntu",
    "opentelemetry-exporter-zipkin-proto-http 3.11 Windows",
    "opentelemetry-exporter-zipkin-proto-http 3.12 Ubuntu",
    "opentelemetry-exporter-zipkin-proto-http 3.12 Windows",
    "opentelemetry-exporter-zipkin-proto-http 3.9 Ubuntu",
    "opentelemetry-exporter-zipkin-proto-http 3.9 Windows",
    "opentelemetry-getting-started",
    "opentelemetry-getting-started 3.10 Ubuntu",
    "opentelemetry-getting-started 3.10 Windows",
    "opentelemetry-getting-started 3.11 Ubuntu",
    "opentelemetry-getting-started 3.11 Windows",
    "opentelemetry-getting-started 3.12 Ubuntu",
    "opentelemetry-getting-started 3.12 Windows",
    "opentelemetry-getting-started 3.9 Ubuntu",
    "opentelemetry-getting-started 3.9 Windows",
    "opentelemetry-opencensus-shim",
    "opentelemetry-opencensus-shim 3.10 Ubuntu",
    "opentelemetry-opencensus-shim 3.10 Windows",
    "opentelemetry-opencensus-shim 3.11 Ubuntu",
    "opentelemetry-opencensus-shim 3.11 Windows",
    "opentelemetry-opencensus-shim 3.12 Ubuntu",
    "opentelemetry-opencensus-shim 3.12 Windows",
    "opentelemetry-opencensus-shim 3.9 Ubuntu",
    "opentelemetry-opencensus-shim 3.9 Windows",
    "opentelemetry-opentracing-shim",
    "opentelemetry-opentracing-shim 3.10 Ubuntu",
    "opentelemetry-opentracing-shim 3.10 Windows",
    "opentelemetry-opentracing-shim 3.11 Ubuntu",
    "opentelemetry-opentracing-shim 3.11 Windows",
    "opentelemetry-opentracing-shim 3.12 Ubuntu",
    "opentelemetry-opentracing-shim 3.12 Windows",
    "opentelemetry-opentracing-shim 3.9 Ubuntu",
    "opentelemetry-opentracing-shim 3.9 Windows",
    "opentelemetry-propagator-b3",
    "opentelemetry-propagator-b3 3.10 Ubuntu",
    "opentelemetry-propagator-b3 3.10 Windows",
    "opentelemetry-propagator-b3 3.11 Ubuntu",
    "opentelemetry-propagator-b3 3.11 Windows",
    "opentelemetry-propagator-b3 3.12 Ubuntu",
    "opentelemetry-propagator-b3 3.12 Windows",
    "opentelemetry-propagator-b3 3.9 Ubuntu",
    "opentelemetry-propagator-b3 3.9 Windows",
    "opentelemetry-propagator-jaeger",
    "opentelemetry-propagator-jaeger 3.10 Ubuntu",
    "opentelemetry-propagator-jaeger 3.10 Windows",
    "opentelemetry-propagator-jaeger 3.11 Ubuntu",
    "opentelemetry-propagator-jaeger 3.11 Windows",
    "opentelemetry-propagator-jaeger 3.12 Ubuntu",
    "opentelemetry-propagator-jaeger 3.12 Windows",
    "opentelemetry-propagator-jaeger 3.9 Ubuntu",
    "opentelemetry-propagator-jaeger 3.9 Windows",
    "opentelemetry-sdk",
    "opentelemetry-sdk 3.10 Ubuntu",
    "opentelemetry-sdk 3.10 Windows",
    "opentelemetry-sdk 3.11 Ubuntu",
    "opentelemetry-sdk 3.11 Windows",
    "opentelemetry-sdk 3.12 Ubuntu",
    "opentelemetry-sdk 3.12 Windows",
    "opentelemetry-sdk 3.9 Ubuntu",
    "opentelemetry-sdk 3.9 Windows",
    "opentelemetry-semantic-conventions",
    "opentelemetry-semantic-conventions 3.10 Ubuntu",
    "opentelemetry-semantic-conventions 3.10 Windows",
    "opentelemetry-semantic-conventions 3.11 Ubuntu",
    "opentelemetry-semantic-conventions 3.11 Windows",
    "opentelemetry-semantic-conventions 3.12 Ubuntu",
    "opentelemetry-semantic-conventions 3.12 Windows",
    "opentelemetry-semantic-conventions 3.9 Ubuntu",
    "opentelemetry-semantic-conventions 3.9 Windows",
    "opentelemetry-test-utils",
    "opentelemetry-test-utils 3.10 Ubuntu",
    "opentelemetry-test-utils 3.10 Windows",
    "opentelemetry-test-utils 3.11 Ubuntu",
    "opentelemetry-test-utils 3.11 Windows",
    "opentelemetry-test-utils 3.12 Ubuntu",
    "opentelemetry-test-utils 3.12 Windows",
    "opentelemetry-test-utils 3.9 Ubuntu",
    "opentelemetry-test-utils 3.9 Windows",
    "public-symbols-check",
    "shellcheck",
    "spellcheck",
    "tracecontext",
  ]
  require_conversation_resolution = true
}

module "branch-protection-rule-opentelemetry-python-1" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-python.node_id
  pattern = "v[0-9]*.[0-9]*.x"
  require_code_owner_reviews = false
  additional_required_status_checks = [
    "build (py36, core, ubuntu-latest)",
    "build (py36, exporter, ubuntu-latest)",
    "build (py36, instrumentation, ubuntu-latest)",
    "build (py36, propagator, ubuntu-latest)",
    "build (py37, core, ubuntu-latest)",
    "build (py37, exporter, ubuntu-latest)",
    "build (py37, instrumentation, ubuntu-latest)",
    "build (py37, propagator, ubuntu-latest)",
    "build (py38, core, ubuntu-latest)",
    "build (py38, exporter, ubuntu-latest)",
    "build (py38, instrumentation, ubuntu-latest)",
    "build (py38, mypy, ubuntu-latest)",
    "build (py38, mypyinstalled, ubuntu-latest)",
    "build (py38, propagator, ubuntu-latest)",
    "build (py38, tracecontext, ubuntu-latest)",
    "build (py39, core, ubuntu-latest)",
    "build (py39, exporter, ubuntu-latest)",
    "build (py39, instrumentation, ubuntu-latest)",
    "build (py39, propagator, ubuntu-latest)",
    "build (pypy3, core, ubuntu-latest)",
    "build (pypy3, exporter, ubuntu-latest)",
    "build (pypy3, instrumentation, ubuntu-latest)",
    "build (pypy3, propagator, ubuntu-latest)",
    "docker-tests",
    "docs",
    "lint",
  ]
  depends_on = [module.branch-protection-rule-opentelemetry-python-0]
}

module "branch-protection-rule-opentelemetry-python-2" {
  source = "./modules/branch-protection-long-term"
  repository_id = module.repo-opentelemetry-python.node_id
  pattern = "release/*"
  require_code_owner_reviews = false
  additional_required_status_checks = [
    "opentelemetry-api",
  ]
  enforce_admins = false
  allows_deletion = true
  depends_on = [module.branch-protection-rule-opentelemetry-python-1]
}

module "branch-protection-rule-opentelemetry-python-3" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-python.node_id
  pattern = "dependabot/**/**"
  depends_on = [module.branch-protection-rule-opentelemetry-python-2]
}

module "branch-protection-rule-opentelemetry-python-4" {
  source = "./modules/branch-protection-feature"
  repository_id = module.repo-opentelemetry-python.node_id
  pattern = "opentelemetrybot/**/**"
  required_status_checks_no_easy_cla = true
  depends_on = [module.branch-protection-rule-opentelemetry-python-3]
}

