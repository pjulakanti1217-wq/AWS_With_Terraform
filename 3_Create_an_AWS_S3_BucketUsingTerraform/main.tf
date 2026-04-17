terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a S3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "pj17-terraform-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}