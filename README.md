# infra-aws-ddb-ecommerce

Infraestrutura Terraform para provisionamento da tabela DynamoDB `ecommerce` utilizada pelo projeto **SthoreH**.

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

## Módulo Terraform

Utiliza o módulo [`DanHenrique/terraform-aws-dynamodb`](https://github.com/DanHenrique/terraform-aws-dynamodb) na versão `v1.2.2`.

## Deploy

O deploy é realizado via GitHub Actions. Os workflows disponíveis são:

- **CI** — valida o código Terraform (`fmt`, `validate`, `plan`) a cada pull request.
- **deploy-dev** — aplica a infraestrutura no ambiente `dev`.
- **deploy-prod** — aplica a infraestrutura no ambiente `prod`.
- **destroy** — destrói a infraestrutura (uso controlado).
