# modules/bucket_two/main.tf

resource "aws_s3_bucket" "bucket_two" {
  bucket = var.bucket_name
  acl    = "private"
}