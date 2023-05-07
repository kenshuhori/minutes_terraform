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
