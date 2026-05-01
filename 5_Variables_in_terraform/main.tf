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

#input variable for environment
variable "environment" {
  default     = "dev"
}

variable "channel_name" {
  default = "pj17"
}

variable "region" {
    default = "us-east-1"  
}

locals {
  bucket_name = "${var.channel_name}-bucket-${var.environment}-${var.region}"
  vpc_name    = "${var.environment}-vpc"
}

# Create a S3 bucket
resource "aws_s3_bucket" "statefile_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name
    Environment = var.environment
  }
}

# Creata a VPC
resource "aws_vpc" "sample_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = local.vpc_name
    Environment = var.environment
  }
}


output "vpc_id" {
    value = aws_vpc.sample_vpc.id 
}

output "bucket_name" {
    value = aws_s3_bucket.statefile_bucket.id
}