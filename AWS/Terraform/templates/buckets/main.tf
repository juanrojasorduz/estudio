# main.tf

provider "aws" {
  region = "us-east-1"
}

module "bucket_one" {
  source   = "./modules/bucket_one"
  bucket_name = var.bucket_one_name

}

module "bucket_two" {
  source   = "./modules/bucket_two"
  bucket_name = var.bucket_two_name
}

module "bucket_three" {
  source   = "./modules/bucket_one"
  bucket_name = var.bucket_three_name
}

module "bucket_four" {
  source   = "./modules/bucket_two"
  bucket_name = var.bucket_four_name
}