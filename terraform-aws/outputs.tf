output "table_arn" {
  description = "ARN of the ecommerce DynamoDB table"
  value       = module.ecommerce_table.table_arn
}

output "table_id" {
  description = "Name (ID) of the ecommerce DynamoDB table"
  value       = module.ecommerce_table.table_id
}