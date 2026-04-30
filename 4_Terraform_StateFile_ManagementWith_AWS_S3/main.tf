terraform {
  backend "s3" {
    bucket = "state-file-bucket-pj17"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
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
resource "aws_s3_bucket" "statefile_bucket" {
  bucket = "state-file-bucket-pj17"

  tags = {
    Name        = "statefile_bucket"
    Environment = "Dev"
  }
}