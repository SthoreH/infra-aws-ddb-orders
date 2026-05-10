# infra-aws-ddb-orders

Infraestrutura Terraform para provisionamento da tabela DynamoDB `orders` utilizada pelo projeto **SthoreH**.

## Sobre a tabela

A tabela segue o padrão **single-table design** do DynamoDB, consolidando múltiplas entidades do domínio de e-commerce em uma única tabela com chaves genéricas (`PK` / `SK`).

| Atributo      | Tipo   | Papel                                      |
|---------------|--------|--------------------------------------------|
| `PK`          | String | Partition key principal                    |
| `SK`          | String | Sort key principal                         |
| `GSI1PK`      | String | Partition key do GSI1                      |
| `GSI1SK`      | String | Sort key do GSI1                           |
| `GSI2PK`      | String | Partition key do GSI2                      |
| `GSI2SK`      | String | Sort key do GSI2                           |
| `entityType`  | String | Tipo da entidade (usado no GSI3)           |
| `createdAt`   | String | Data de criação (usado no GSI3)            |
| `expiresAt`   | Number | TTL — itens expirados são removidos automaticamente |

### Índices Secundários Globais (GSI)

| GSI   | Hash Key     | Sort Key     | Finalidade                                    |
|-------|--------------|--------------|-----------------------------------------------|
| GSI1  | `GSI1PK`     | `GSI1SK`     | Padrão de acesso alternativo #1               |
| GSI2  | `GSI2PK`     | `GSI2SK`     | Padrão de acesso alternativo #2               |
| GSI3  | `entityType` | `createdAt`  | Listagem de entidades por tipo e data de criação |

### Configurações gerais

- **Billing mode:** `PAY_PER_REQUEST` — sem capacidade pré-provisionada, escala automaticamente.
- **TTL:** habilitado via atributo `expiresAt`, para expiração automática de itens temporários (ex.: sessões, tokens).
- **Deletion protection:** desabilitado em `dev`, habilitado em `prod`.

## Ambientes

| Ambiente | Deletion Protection |
|----------|---------------------|
| `dev`    | `false`             |
| `prod`   | `true`              |

## Stack

- **IaC:** Terraform 1.14.8, AWS Provider 6.40.0, region `sa-east-1` (versão pinada em [.pipeline.yml](.pipeline.yml); o módulo externo `DanHenrique/terraform-aws-dynamodb@v1.2.2` pina exatamente 1.14.8 — bumpar para 1.14.9 quando o módulo aceitar).
- **Backend:** S3 partial config — bucket via `vars.TF_STATE_BUCKET`, key = `infra-aws-ddb-orders/terraform.tfstate`.
- **Módulos:** [`DanHenrique/terraform-aws-dynamodb@v1.2.2`](https://github.com/DanHenrique/terraform-aws-dynamodb), [`SthoreH/shd-terraform-aws-iam@v1.0.1`](https://github.com/SthoreH/shd-terraform-aws-iam).
- **CI/CD:** workflows reutilizáveis em [`shd-github-actions-workflows`](https://github.com/SthoreH/shd-github-actions-workflows) (pin atual: `@v1.6.0`).

## Configuração do repositório

A pipeline espera dois GitHub Environments — `dev` e `prod` — cada um definindo as variables `AWS_ROLE_ARN` e `TF_STATE_BUCKET`. A trust policy da IAM role precisa aceitar OIDC do GitHub para esse repo.

Branch e tag protection são gerenciadas pelos rulesets em [.github/rulesets/](.github/rulesets/). Importe via `Settings → Rules → Rulesets → New ruleset → Import a ruleset`.

## Pipeline

Caller workflows vivem em [.github/workflows/](.github/workflows/). São thin wrappers dos reusable workflows e composite actions em [shd-github-actions-workflows](../../shd/shd-github-actions-workflows/) — veja o README desse repo para o que cada peça faz.

- [ci-dev.yml](.github/workflows/ci-dev.yml), [ci-prod.yml](.github/workflows/ci-prod.yml) — PR validation (terraform fmt/validate/plan).
- [deploy-dev.yml](.github/workflows/deploy-dev.yml), [deploy-prod.yml](.github/workflows/deploy-prod.yml) — deploys em push para `dev`/`main`. `prod` adicionalmente roda semantic-release.
- [rollback.yml](.github/workflows/rollback.yml) — re-aplica numa tag anterior via issue rotulada.
- [destroy.yml](.github/workflows/destroy.yml) — destrói infra de `dev` via issue rotulada.

## Operações

**Rollback** — abrir issue com o [rollback request template](.github/ISSUE_TEMPLATE/rollback_request.yml) e aplicar o label `rollback-approved`.

**Destroy** — abrir issue com o [destroy request template](.github/ISSUE_TEMPLATE/destroy_request.yml) e aplicar o label `destroy-approved`. Restrito a `dev`; destruição de `prod` é operação manual via CLI.
