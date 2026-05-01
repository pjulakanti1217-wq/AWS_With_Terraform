
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


