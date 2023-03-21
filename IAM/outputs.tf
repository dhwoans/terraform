output "aws_iam_arn" {
  value = aws_iam_user.iam_user.*.arn
}
output "password" {
  value = aws_iam_user_login_profile.admin.encrypted_password
  description = "terraform output -raw password | base64 --decode | keybase pgp decrypt"
}
