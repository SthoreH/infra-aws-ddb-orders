variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be 'dev' or 'prod'."
  }
}

variable "organization" {
  description = "GitHub organization name, used in resource tags"
  type        = string
  default     = "SthoreH"
}

variable "deletion_protection_enabled" {
  description = "Enable DynamoDB deletion protection (should be true in prod)"
  type        = bool
  default     = false
}