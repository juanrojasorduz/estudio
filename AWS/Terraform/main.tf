terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket =  var.bucket_name  # Replace with a globally unique bucket name
  acl    = "private"  # Optional: Default access control list (ACL) for the bucket
}