output "vpc_id" {
    value = aws_vpc.sample_vpc.id 
}

output "bucket_name" {
    value = aws_s3_bucket.statefile_bucket.id
}