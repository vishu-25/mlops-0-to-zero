variable "aws_region" {
  description = "AWS Region to deploy resources in"
  type = string
  default = "us-east-1"
}

variable "environment" {
    description = "Deployment environment (e.g., dev, staging, prod)"
    type = string
    default = "dev"

    validation {
      condition = contains(["dev", "staging", "prod"], var.environment)
      error_message = "environment must be one of:  dev, staging, prod"
      
    }
}

variable "bucket_name" {
    description = "Name of the S3 bucket to store data"
    type = string
    default = "vismay-mlops-dvc-demo"
}

variable "tags" {
    description = "Tags to apply to deployed resources"
    type = map(string)
    default = {}
}