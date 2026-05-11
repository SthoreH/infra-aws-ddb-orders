terraform {
  required_version = "1.14.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }

  backend "s3" {
    region = "sa-east-1"
  }
}
