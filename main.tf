# 계정 ID 가져오기
data "aws_caller_identity" "current" {}

# S3 모듈 호출
module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment
}

# CICD 모듈 호출
module "cicd" {
  source = "./modules/cicd"

  project_name    = var.project_name
  environment     = var.environment
  artifact_bucket = module.s3.bucket_name
  
  # GitHub 연동 설정
  github_owner    = var.github_owner
  github_repo     = var.github_repo
  github_branch   = var.github_branch
}

# Web 모듈 호출
module "web" {
  source = "./modules/web"

  project_name    = var.project_name
  environment     = var.environment
  bucket_id       = module.s3.bucket_id
  bucket_arn      = module.s3.bucket_arn
}