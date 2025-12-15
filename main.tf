terraform {
  backend "s3" {}
}

provider "aws" {
  region                      = var.region
  access_key                  = var.access_key
  secret_key                  = var.secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  s3_force_path_style         = true
  endpoints {
    s3 = "http://localhost:4566" # LocalStack endpoint for S3
  }
}

# Variables
variable "region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

# Resource: S3 Bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "TestBucket"
    Environment = terraform.workspace
  }
}

# Output the bucket name
output "bucket_name" {
  value       = aws_s3_bucket.test_bucket.bucket
  description = "The name of the S3 bucket"
}

