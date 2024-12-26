# modules/bucket_one/outputs.tf

output "bucket_name" {
  value = aws_s3_bucket.bucket_one.bucket
}