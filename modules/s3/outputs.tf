output "bucket_name" {
  description = "S3 버킷 이름"
  value       = aws_s3_bucket.website.id
}

output "bucket_arn" {
  description = "S3 버킷 ARN"
  value       = aws_s3_bucket.website.arn
}

output "bucket_id" {
  description = "S3 버킷 ID"
  value       = aws_s3_bucket.website.id
}

output "website_endpoint" {
  description = "S3 웹사이트 엔드포인트"
  value       = aws_s3_bucket.website.website_endpoint
}

output "website_domain" {
  description = "S3 웹사이트 도메인"
  value       = aws_s3_bucket.website.website_domain
}