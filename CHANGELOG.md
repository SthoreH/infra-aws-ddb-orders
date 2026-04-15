# Changelog

## [1.0.0] - 2026-04-14

### Added
- Tabela DynamoDB `ecommerce` com single-table design (PK + SK)
- GSI1 e GSI2 para padrões de acesso alternativos
- GSI3 (`entityType` + `createdAt`) para listagem de entidades por tipo e data
- TTL via atributo `expiresAt`
- Billing mode `PAY_PER_REQUEST`
- Deletion protection habilitado para `prod`
- Workflows de CI/CD: `ci`, `deploy-dev`, `deploy-prod`, `destroy`
