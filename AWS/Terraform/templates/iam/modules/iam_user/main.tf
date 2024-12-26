resource "aws_iam_user" "user" {
  name = var.user_name
}

resource "aws_iam_user_policy" "user_policy" {
  name = "user-policy"
  user = aws_iam_user.user.name
  policy = var.user_policy
}