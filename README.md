# GitHub Administration for the OpenTelemetry org

To submit a PR, push a branch name starting with `pr/` to this repository,
and then open a PR from that branch.

## What is managed and what is not?

The following are managed in this repository:

- Repository settings (found in `repo-*.tf`)
  - General
  - Collaborators and teams
  - Branches
- Basic team info (found in [`teams.tf`](./teams.tf))
  - Name
  - Description
  - Parent team

Notably, the following are not managed:

- Repository settings
  - Secrets and variables
- [Team members](https://github.com/open-telemetry/admin/issues/58)
- [Org settings](https://github.com/open-telemetry/admin/issues/57)
