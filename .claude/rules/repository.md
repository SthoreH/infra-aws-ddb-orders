---
# No path restriction — applies to every file in the project
---

# Repository Conventions

## IaC

- **IaC always in:** `terraform-aws/` at the root of each repository.

## Pipeline

- Pipeline logic is delegated to [shd-github-actions-workflows](../../../../shd/shd-github-actions-workflows/). Caller workflows in `.github/workflows/` are thin wrappers. Do not inline `terraform init/apply/destroy` here.
- `.pipeline.yml` at the repo root is the single source of truth for terraform version, paths, and per-env values.

## Commits

- Every commit must follow the Conventional Commits specification — `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `test:`, `ci:`.
