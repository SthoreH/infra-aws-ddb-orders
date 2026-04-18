locals {
  table_name = "orders"

  tags = {
    ManagedBy   = "terraform"
    Repository  = "github.com/SthoreH/infra-aws-ddb-orders"
  }
}