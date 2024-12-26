provider "aws" {
  region = var.aws_region
}

module "iam_user" {
  source     = "./modules/iam_user"
  user_name  = var.user_name
  user_policy = var.user_policy
}

module "iam_role" {
  source     = "./modules/iam_role"
  role_name  = var.role_name
  assume_role_policy = var.assume_role_policy
}

output "iam_user_name" {
  value = module.iam_user.iam_user_name
}

output "iam_role_name" {
  value = module.iam_role.iam_role_name
}