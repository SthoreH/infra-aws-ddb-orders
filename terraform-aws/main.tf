

module "ecommerce_table" {
  source = "github.com/DanHenrique/terraform-aws-dynamodb?ref=v1.2.2"

  table_name = local.table_name
  hash_key   = "PK"
  range_key  = "SK"

  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = var.deletion_protection_enabled

  attributes = [
    { name = "PK", type = "S" },
    { name = "SK", type = "S" },
    { name = "GSI1PK", type = "S" },
    { name = "GSI1SK", type = "S" },
    { name = "GSI2PK", type = "S" },
    { name = "GSI2SK", type = "S" },
    { name = "entityType", type = "S" },
    { name = "createdAt", type = "S" },
  ]

  ttl_attribute = "expiresAt"

  global_secondary_indexes = [
    {
      name            = "GSI1"
      hash_key        = "GSI1PK"
      range_key       = "GSI1SK"
      projection_type = "ALL"
    },
    {
      name            = "GSI2"
      hash_key        = "GSI2PK"
      range_key       = "GSI2SK"
      projection_type = "ALL"
    },
    {
      name            = "GSI3"
      hash_key        = "entityType"
      range_key       = "createdAt"
      projection_type = "ALL"
    },
  ]

  tags = local.tags
}