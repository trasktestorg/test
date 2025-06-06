resource "github_team" "admins" {
  name        = "admins"
  description = ""
  privacy     = "closed"
}

resource "github_team" "android-approvers" {
  name        = "android-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "android-maintainers" {
  name        = "android-maintainers"
  parent_team_id = github_team.android-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "arrow-approvers" {
  name        = "arrow-approvers"
  parent_team_id = github_team.arrow-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "arrow-maintainers" {
  name        = "arrow-maintainers"
  parent_team_id = github_team.arrow-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "arrow-triagers" {
  name        = "arrow-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "assign-reviewers-action-maintainers" {
  name        = "assign-reviewers-action-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "blog-approvers" {
  name        = "blog-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "build-tools-approvers" {
  name        = "build-tools-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-approvers" {
  name        = "collector-approvers"
  parent_team_id = github_team.collector-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-contrib-approvers" {
  name        = "collector-contrib-approvers"
  parent_team_id = github_team.collector-contrib-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-contrib-maintainers" {
  name        = "collector-contrib-maintainers"
  parent_team_id = github_team.collector-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-contrib-triagers" {
  name        = "collector-contrib-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-maintainers" {
  name        = "collector-maintainers"
  parent_team_id = github_team.collector-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-releases-approvers" {
  name        = "collector-releases-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "collector-triagers" {
  name        = "collector-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "configuration-approvers" {
  name        = "configuration-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "configuration-maintainers" {
  name        = "configuration-maintainers"
  parent_team_id = github_team.configuration-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "cpp-approvers" {
  name        = "cpp-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "cpp-contrib-approvers" {
  name        = "cpp-contrib-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "cpp-contrib-maintainers" {
  name        = "cpp-contrib-maintainers"
  parent_team_id = github_team.cpp-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "cpp-maintainers" {
  name        = "cpp-maintainers"
  parent_team_id = github_team.cpp-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "demo-approvers" {
  name        = "demo-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "demo-maintainers" {
  name        = "demo-maintainers"
  parent_team_id = github_team.demo-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-approvers" {
  name        = "docs-approvers"
  parent_team_id = github_team.docs-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-bn-approvers" {
  name        = "docs-bn-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-bn-maintainers" {
  name        = "docs-bn-maintainers"
  parent_team_id = github_team.docs-bn-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-es-approvers" {
  name        = "docs-es-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-es-maintainers" {
  name        = "docs-es-maintainers"
  parent_team_id = github_team.docs-es-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-fr-approvers" {
  name        = "docs-fr-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-fr-maintainers" {
  name        = "docs-fr-maintainers"
  parent_team_id = github_team.docs-fr-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-ja-approvers" {
  name        = "docs-ja-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-ja-maintainers" {
  name        = "docs-ja-maintainers"
  parent_team_id = github_team.docs-ja-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-maintainers" {
  name        = "docs-maintainers"
  parent_team_id = github_team.docs-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-pt-approvers" {
  name        = "docs-pt-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-pt-maintainers" {
  name        = "docs-pt-maintainers"
  parent_team_id = github_team.docs-pt-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-triagers" {
  name        = "docs-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-zh-approvers" {
  name        = "docs-zh-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "docs-zh-maintainers" {
  name        = "docs-zh-maintainers"
  parent_team_id = github_team.docs-zh-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-approvers" {
  name        = "dotnet-approvers"
  parent_team_id = github_team.dotnet-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-contrib-approvers" {
  name        = "dotnet-contrib-approvers"
  parent_team_id = github_team.dotnet-contrib-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-contrib-maintainers" {
  name        = "dotnet-contrib-maintainers"
  parent_team_id = github_team.dotnet-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-contrib-triagers" {
  name        = "dotnet-contrib-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-instrumentation-approvers" {
  name        = "dotnet-instrumentation-approvers"
  parent_team_id = github_team.dotnet-instrumentation-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-instrumentation-maintainers" {
  name        = "dotnet-instrumentation-maintainers"
  parent_team_id = github_team.dotnet-instrumentation-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-instrumentation-triagers" {
  name        = "dotnet-instrumentation-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-maintainers" {
  name        = "dotnet-maintainers"
  parent_team_id = github_team.dotnet-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "dotnet-triagers" {
  name        = "dotnet-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "ebpf-instrumentation-approvers" {
  name        = "ebpf-instrumentation-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "ebpf-instrumentation-maintainers" {
  name        = "ebpf-instrumentation-maintainers"
  parent_team_id = github_team.ebpf-instrumentation-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "ebpf-profiler-approvers" {
  name        = "ebpf-profiler-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "ebpf-profiler-maintainers" {
  name        = "ebpf-profiler-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "entities-maintainers" {
  name        = "entities-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "erlang-approvers" {
  name        = "erlang-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "erlang-contrib-approvers" {
  name        = "erlang-contrib-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "erlang-contrib-maintainers" {
  name        = "erlang-contrib-maintainers"
  parent_team_id = github_team.erlang-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "erlang-maintainers" {
  name        = "erlang-maintainers"
  parent_team_id = github_team.erlang-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-approvers" {
  name        = "go-approvers"
  parent_team_id = github_team.go-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-compile-instrumentation-approvers" {
  name        = "go-compile-instrumentation-approvers"
  parent_team_id = github_team.go-compile-instrumentation-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-compile-instrumentation-maintainers" {
  name        = "go-compile-instrumentation-maintainers"
  parent_team_id = github_team.go-compile-instrumentation-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-compile-instrumentation-triagers" {
  name        = "go-compile-instrumentation-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-instrumentation-approvers" {
  name        = "go-instrumentation-approvers"
  parent_team_id = github_team.go-instrumentation-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-instrumentation-maintainers" {
  name        = "go-instrumentation-maintainers"
  parent_team_id = github_team.go-instrumentation-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-instrumentation-triagers" {
  name        = "go-instrumentation-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-maintainers" {
  name        = "go-maintainers"
  parent_team_id = github_team.go-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "go-triagers" {
  name        = "go-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "governance-committee" {
  name        = "governance-committee"
  description = ""
  privacy     = "closed"
}

resource "github_team" "helm-approvers" {
  name        = "helm-approvers"
  parent_team_id = github_team.helm-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "helm-maintainers" {
  name        = "helm-maintainers"
  parent_team_id = github_team.helm-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "helm-triagers" {
  name        = "helm-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "injector-approvers" {
  name        = "injector-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "injector-maintainers" {
  name        = "injector-maintainers"
  parent_team_id = github_team.injector-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-approvers" {
  name        = "java-approvers"
  parent_team_id = github_team.java-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-contrib-approvers" {
  name        = "java-contrib-approvers"
  parent_team_id = github_team.java-contrib-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-contrib-maintainers" {
  name        = "java-contrib-maintainers"
  parent_team_id = github_team.java-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-contrib-triagers" {
  name        = "java-contrib-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-instrumentation-approvers" {
  name        = "java-instrumentation-approvers"
  parent_team_id = github_team.java-instrumentation-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-instrumentation-maintainers" {
  name        = "java-instrumentation-maintainers"
  parent_team_id = github_team.java-instrumentation-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-instrumentation-triagers" {
  name        = "java-instrumentation-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-maintainers" {
  name        = "java-maintainers"
  parent_team_id = github_team.java-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "java-triagers" {
  name        = "java-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "javascript-approvers" {
  name        = "javascript-approvers"
  parent_team_id = github_team.javascript-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "javascript-contrib-triagers" {
  name        = "javascript-contrib-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "javascript-maintainers" {
  name        = "javascript-maintainers"
  parent_team_id = github_team.javascript-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "javascript-triagers" {
  name        = "javascript-triagers"
  parent_team_id = github_team.javascript-contrib-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "lambda-extension-approvers" {
  name        = "lambda-extension-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "lambda-extension-maintainers" {
  name        = "lambda-extension-maintainers"
  parent_team_id = github_team.lambda-extension-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "network-approvers" {
  name        = "network-approvers"
  parent_team_id = github_team.network-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "network-maintainers" {
  name        = "network-maintainers"
  parent_team_id = github_team.network-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "network-triagers" {
  name        = "network-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-go-approvers" {
  name        = "opamp-go-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-go-maintainers" {
  name        = "opamp-go-maintainers"
  parent_team_id = github_team.opamp-go-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-java-approvers" {
  name        = "opamp-java-approvers"
  parent_team_id = github_team.opamp-java-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-java-maintainers" {
  name        = "opamp-java-maintainers"
  parent_team_id = github_team.opamp-java-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-java-triagers" {
  name        = "opamp-java-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-spec-approvers" {
  name        = "opamp-spec-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "opamp-spec-maintainers" {
  name        = "opamp-spec-maintainers"
  parent_team_id = github_team.opamp-spec-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "opentelemetry-python-contrib-approvers" {
  name        = "opentelemetry-python-contrib-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "opentelemetry-python-contrib-maintainers" {
  name        = "opentelemetry-python-contrib-maintainers"
  parent_team_id = github_team.opentelemetry-python-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "operator-approvers" {
  name        = "operator-approvers"
  parent_team_id = github_team.operator-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "operator-maintainers" {
  name        = "operator-maintainers"
  parent_team_id = github_team.operator-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "operator-ta-maintainers" {
  name        = "operator-ta-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "operator-triagers" {
  name        = "operator-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "otel-elections" {
  name        = "otel-elections"
  description = ""
  privacy     = "closed"
}

resource "github_team" "php-approvers" {
  name        = "php-approvers"
  parent_team_id = github_team.php-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "php-maintainers" {
  name        = "php-maintainers"
  parent_team_id = github_team.php-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "php-triagers" {
  name        = "php-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "profiling-approvers" {
  name        = "profiling-approvers"
  parent_team_id = github_team.profiling-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "profiling-maintainers" {
  name        = "profiling-maintainers"
  parent_team_id = github_team.profiling-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "profiling-triagers" {
  name        = "profiling-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "project-infra" {
  name        = "project-infra"
  description = ""
  privacy     = "closed"
}

resource "github_team" "prometheus-interoperability" {
  name        = "prometheus-interoperability"
  description = ""
  privacy     = "closed"
}

resource "github_team" "proto-go-approvers" {
  name        = "proto-go-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "proto-go-maintainers" {
  name        = "proto-go-maintainers"
  parent_team_id = github_team.proto-go-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "python-approvers" {
  name        = "python-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "python-maintainers" {
  name        = "python-maintainers"
  parent_team_id = github_team.python-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "ruby-approvers" {
  name        = "ruby-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "ruby-contrib-approvers" {
  name        = "ruby-contrib-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "ruby-contrib-maintainers" {
  name        = "ruby-contrib-maintainers"
  parent_team_id = github_team.ruby-contrib-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "ruby-maintainers" {
  name        = "ruby-maintainers"
  parent_team_id = github_team.ruby-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "rust-approvers" {
  name        = "rust-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "rust-maintainers" {
  name        = "rust-maintainers"
  parent_team_id = github_team.rust-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "rust-publishers" {
  name        = "rust-publishers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sandbox-web-js-maintainers" {
  name        = "sandbox-web-js-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-android-approvers" {
  name        = "semconv-android-approvers"
  parent_team_id = github_team.semconv-client-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-browser-approvers" {
  name        = "semconv-browser-approvers"
  parent_team_id = github_team.semconv-client-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-cicd-approvers" {
  name        = "semconv-cicd-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-client-approvers" {
  name        = "semconv-client-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-code-attribute-approvers" {
  name        = "semconv-code-attribute-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-container-approvers" {
  name        = "semconv-container-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-db-approvers" {
  name        = "semconv-db-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-dotnet-approver" {
  name        = "semconv-dotnet-approver"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-feature-flag-approvers" {
  name        = "semconv-feature-flag-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-genai-approvers" {
  name        = "semconv-genai-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-http-approvers" {
  name        = "semconv-http-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-ios-approvers" {
  name        = "semconv-ios-approvers"
  parent_team_id = github_team.semconv-client-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-jvm-approvers" {
  name        = "semconv-jvm-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-k8s-approvers" {
  name        = "semconv-k8s-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-log-approvers" {
  name        = "semconv-log-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-messaging-approvers" {
  name        = "semconv-messaging-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-mobile-approvers" {
  name        = "semconv-mobile-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-sdk-health-approvers" {
  name        = "semconv-sdk-health-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-security-approvers" {
  name        = "semconv-security-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "semconv-system-approvers" {
  name        = "semconv-system-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-contributor-experience-approvers" {
  name        = "sig-contributor-experience-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-contributor-experience-maintainers" {
  name        = "sig-contributor-experience-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-developer-experience-approvers" {
  name        = "sig-developer-experience-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-developer-experience-maintainers" {
  name        = "sig-developer-experience-maintainers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-end-user-approvers" {
  name        = "sig-end-user-approvers"
  parent_team_id = github_team.sig-end-user-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-end-user-maintainers" {
  name        = "sig-end-user-maintainers"
  parent_team_id = github_team.sig-end-user-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-end-user-triagers" {
  name        = "sig-end-user-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-mainframe-approvers" {
  name        = "sig-mainframe-approvers"
  parent_team_id = github_team.sig-mainframe-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-mainframe-maintainers" {
  name        = "sig-mainframe-maintainers"
  parent_team_id = github_team.sig-mainframe-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-mainframe-triagers" {
  name        = "sig-mainframe-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-project-infra-approvers" {
  name        = "sig-project-infra-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-project-infra-maintainers" {
  name        = "sig-project-infra-maintainers"
  parent_team_id = github_team.sig-project-infra-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-security-approvers" {
  name        = "sig-security-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sig-security-maintainers" {
  name        = "sig-security-maintainers"
  parent_team_id = github_team.sig-security-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "spec-sponsors" {
  name        = "spec-sponsors"
  parent_team_id = github_team.specs-triagers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-entities-approvers" {
  name        = "specs-entities-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-logs-approvers" {
  name        = "specs-logs-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-metrics-approvers" {
  name        = "specs-metrics-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-semconv-approvers" {
  name        = "specs-semconv-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-semconv-maintainers" {
  name        = "specs-semconv-maintainers"
  parent_team_id = github_team.specs-semconv-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-trace-approvers" {
  name        = "specs-trace-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "specs-triagers" {
  name        = "specs-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sqlcommenter-approvers" {
  name        = "sqlcommenter-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "sqlcommenter-maintainers" {
  name        = "sqlcommenter-maintainers"
  parent_team_id = github_team.sqlcommenter-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "swift-approvers" {
  name        = "swift-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "swift-maintainers" {
  name        = "swift-maintainers"
  parent_team_id = github_team.swift-approvers.id
  description = ""
  privacy     = "closed"
}

resource "github_team" "swift-triagers" {
  name        = "swift-triagers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "technical-committee" {
  name        = "technical-committee"
  description = ""
  privacy     = "closed"
}

resource "github_team" "weaver-approvers" {
  name        = "weaver-approvers"
  description = ""
  privacy     = "closed"
}

resource "github_team" "weaver-maintainers" {
  name        = "weaver-maintainers"
  parent_team_id = github_team.weaver-approvers.id
  description = ""
  privacy     = "closed"
}

