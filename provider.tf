# Terraform 설정
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # 나중에 S3 백엔드 설정을 추가할 수 있습니다
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "minipro3/terraform.tfstate"
  #   region = "ap-northeast-2"
  # }
}

# AWS 프로바이더 설정
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}