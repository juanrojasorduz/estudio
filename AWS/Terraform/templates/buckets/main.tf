# main.tf

provider "aws" {
  region = "us-west-2"
}

module "bucket_one" {
  source   = "./modules/bucket_one"
  bucket_name = var.bucket_one_name
}

module "bucket_two" {
  source   = "./modules/bucket_two"
  bucket_name = var.bucket_two_name
}

output "bucket_one_name" {
  value = module.bucket_one.bucket_name
}

output "bucket_two_name" {
  value = module.bucket_two.bucket_name
}