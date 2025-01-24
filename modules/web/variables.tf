variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment" {
  description = "환경 (dev, prod 등)"
  type        = string
}

variable "bucket_id" {
  description = "S3 버킷 ID"
  type        = string
}

variable "bucket_arn" {
  description = "S3 버킷 ARN"
  type        = string
}

variable "price_class" {
  description = "CloudFront 가격 등급"
  type        = string
  default     = "PriceClass_100"  # 가장 저렴한 옵션
}

variable "default_ttl" {
  description = "기본 TTL (초)"
  type        = number
  default     = 3600
}