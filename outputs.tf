# S3 관련 출력
output "website_bucket_name" {
  description = "S3 버킷 이름"
  value       = module.s3.bucket_name
}

output "website_endpoint" {
  description = "S3 웹사이트 엔드포인트"
  value       = module.s3.website_endpoint
}

# CICD 관련 출력
output "pipeline_name" {
  description = "CodePipeline 이름"
  value       = module.cicd.pipeline_name
}

output "pipeline_url" {
  description = "CodePipeline 콘솔 URL"
  value       = module.cicd.pipeline_url
}

# 배포 정보
output "deployment_info" {
  description = "배포 관련 정보"
  value = {
    environment = var.environment
    region      = var.aws_region
    project     = var.project_name
  }
}