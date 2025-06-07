terraform{
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = var.s3_bucket
    key            = var.s3_key
    region         = var.aws_region
    dynamodb_table = var.dynamodb_table
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}