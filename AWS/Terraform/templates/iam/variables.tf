variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "user_name" {
  description = "Name of the IAM user"
  type        = string
}

variable "user_policy" {
  description = "IAM policy to attach to the user"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "Assume role policy document for the IAM role"
  type        = string
}