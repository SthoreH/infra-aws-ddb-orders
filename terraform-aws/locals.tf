locals {
  table_name = "ecommerce"

  tags = {
    Project     = "SthoreH"
    Environment = var.environment
    ManagedBy   = "terraform"
    Repository  = "github.com/SthoreH/infra-aws-ddb-ecommerce"
    Creator     = "danhenrique"
  }
}