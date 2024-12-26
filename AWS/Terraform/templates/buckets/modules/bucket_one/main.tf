# modules/bucket_one/main.tf

resource "aws_s3_bucket" "bucket_one" {
  bucket = var.bucket_name
  acl    = "private"
}