# IAM
module "lambda_role" {
  source        = "../../modules/iam/lambda"
  iam_role_name = "minutes-serverless-prod-ap-northeast-1-lambdaRole"
}

# VPC Endpoint
module "vpc_endpoint" {
  source      = "../../modules/vpc_endpoint"
  environment = "prod"
  vpc_id      = "vpc-01e1da440d6749df8"
}

# S3
module "s3" {
  source      = "../../modules/s3"
  environment = "prod"
  bucket_name = "minutes-prod-contents"
  allow_vpces = [module.vpc_endpoint.id]
}

# ParameterStore
module "parameter_store_secure_string" {
  source = "../../modules/parameter_stores/secure_strings"
  parameters = {
    "/minutes/prod/YOUTUBE_DATA_API_KEY" = ""
  }
}
