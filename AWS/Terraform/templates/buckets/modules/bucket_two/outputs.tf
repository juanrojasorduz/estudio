# modules/bucket_two/outputs.tf

output "bucket_name" {
  value = aws_s3_bucket.bucket_two.bucket
}