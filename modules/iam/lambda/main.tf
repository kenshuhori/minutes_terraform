resource "aws_iam_role_policy_attachment" "template" {
  role       = aws_iam_role.template.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role" "template" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json
  tags = {
    STAGE = "prod"
  }
}

data "aws_iam_policy_document" "lambda_assume_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}
