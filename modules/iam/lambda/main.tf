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

resource "aws_iam_role_policy" "template" {
  name = "minutes-serverless-prod-lambda"
  role = var.iam_role_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:TagResource"
        ]
        Resource : [
          "arn:aws:logs:ap-northeast-1:345185900516:log-group:/aws/lambda/minutes-serverless-prod*:*"
        ],
        Effect : "Allow"
      },
      {
        Action : [
          "logs:PutLogEvents"
        ],
        Resource : [
          "arn:aws:logs:ap-northeast-1:345185900516:log-group:/aws/lambda/minutes-serverless-prod*:*:*"
        ],
        Effect : "Allow"
      },
      {
        Sid : "VisualEditor0",
        Effect : "Allow",
        Action : [
          "kms:Decrypt",
          "ssm:GetParameter"
        ],
        Resource : [
          "arn:aws:kms:ap-northeast-1:345185900516:key/cec7b1ba-32d0-48ec-a014-51694fd24e33",
          "arn:aws:ssm:ap-northeast-1:345185900516:parameter/*"
        ]
      }
    ]
  })
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
