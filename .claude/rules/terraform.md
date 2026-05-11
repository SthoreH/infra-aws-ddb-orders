---
paths:
  - "terraform-aws/**"
  - "**/*.tf"
---

# Terraform Rules

- **Terraform version:** pinned in [.pipeline.yml](../../.pipeline.yml) under `infra.terraform-version`. Do not hardcode elsewhere. **AWS Provider:** `6.40.0`.
- **Backend:** S3 with partial config — bucket injected by pipeline via `terraform init -backend-config`.
- **State key:** `{repo-name}/terraform.tfstate`.
- **IaC always in:** `terraform-aws/` at the root of each repository.
- **Required tags on every resource:** `ManagedBy=terraform`, `Repository`.
- **Reusable modules:** `source = "github.com/SthoreH/{module}?ref=vX.Y.Z"`.

## AWS Provider Conventions

- **AWS Region:** `sa-east-1`.
- **Secrets:** AWS Secrets Manager only — never in `.tfvars`, env vars, or code.
