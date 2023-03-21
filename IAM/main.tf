resource "aws_iam_user" "iam_user" {
  name = var.iam_user_name
  force_destroy = true
}

resource "aws_iam_user_login_profile" "admin" {
  user    = aws_iam_user.iam_user.name
  pgp_key = "keybase:fiveisdoor"
}

resource "aws_iam_group" "iam_group" {
  name = var.iam_group
}

resource "aws_iam_group_membership" "iam_group" {
  name = aws_iam_group.iam_group.name

  users = [
    aws_iam_user.iam_user.name
  ]

  group = aws_iam_group.iam_group.name
}

resource "aws_iam_group_policy" "admin" {
  name   = "iam_access_policy_for_admin"
  group  = aws_iam_group.iam_group.id
  policy = data.aws_iam_policy_document.AdministratorAccess.json
}

data "aws_iam_policy_document" "AdministratorAccess" {
  # AdministratorAccess
	statement {
		actions   = ["*"]
		effect    = "Allow"
		resources = ["*"]
	}
}