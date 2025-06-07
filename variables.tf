variable aws_region {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable ami_id {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Example AMI ID, replace with a valid one
}

variable instance_type {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t2.micro" # Example instance type, replace with a valid one
}

variable keypair_name {
  description = "The name of the key pair to use for SSH access to the EC2 instance"
  type        = string
  default     = "my-keypair" # Replace with your actual key pair name
}

variable s3_bucket {
  description = "The name of the S3 bucket for storing Terraform state"
  type        = string
  default     = "my-terraform-state-bucket" # Replace with your actual S3 bucket name
}

variable s3_key {
  description = "The key for the Terraform state file in S3"
  type        = string
  default     = "terraform/state.tfstate"
}

variable dynamodb_table {
  description = "The name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-state-lock" # Replace with your actual DynamoDB table name
}

