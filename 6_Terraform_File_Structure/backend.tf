terraform {
  backend "s3" {
    bucket = "state-file-bucket-pj17"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}
