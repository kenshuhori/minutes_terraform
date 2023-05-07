provider "aws" {
  region  = "ap-northeast-1"
  profile = "minutes"
}

terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    profile = "minutes"
    bucket  = "minutes-terraform-state"
    key     = "terraform.tfstate"
    region  = "ap-northeast-1"
  }
}
