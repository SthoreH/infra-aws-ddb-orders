# Repo: infra-aws-ddb-orders

Infraestrutura Terraform para a tabela DynamoDB `orders` (single-table design + 3 GSIs) e suas IAM policies RO/RW.

## Layout

- [terraform-aws/](../terraform-aws/) — IaC (DynamoDB + IAM policies templated).
- [.pipeline.yml](../.pipeline.yml) — pipeline configuration consumed by the shared workflows. **Single source of truth** for terraform version, paths, and per-env values. Do not hardcode any of these in workflows or rules.
- [.github/workflows/](../.github/workflows/) — caller workflows. Thin wrappers; logic lives upstream.

## Pipeline is delegated

CI/CD lives in [shd-github-actions-workflows](../../../shd/shd-github-actions-workflows/). Caller workflows here only invoke reusable workflows or composite actions there. **If a step needs to change, change it in shd and bump the pin.** Do not inline pipeline logic locally.

Current pin: `@v1.6.0`.

## Granular rules

Topic-specific guidance lives in [.claude/rules/](rules/) — `terraform.md` e `repository.md`.
