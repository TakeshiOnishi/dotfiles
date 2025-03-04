# Terraform サンプル

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket"
  acl    = "private"
}

output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}
