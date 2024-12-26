# modules/bucket_one/main.tf

resource "aws_s3_bucket" "bucket_one" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "example_boc" {
  bucket = aws_s3_bucket.bucket_one.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket_one.id
  versioning_configuration {
    status = "Enabled"
  }
}