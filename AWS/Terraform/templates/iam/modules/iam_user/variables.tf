variable "user_name" {
  description = "Name of the IAM user"
  type        = string
}

variable "user_policy" {
  description = "IAM policy to attach to the user"
  type        = string
}