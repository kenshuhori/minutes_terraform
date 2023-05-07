resource "aws_vpc_endpoint" "template" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.ap-northeast-1.s3"

  tags = {
    Name        = "minutes"
    Environment = var.environment
  }
}
