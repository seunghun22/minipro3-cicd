variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment" {
  description = "환경 (dev, prod 등)"
  type        = string
}

variable "artifact_bucket" {
  description = "아티팩트 저장용 S3 버킷 이름"
  type        = string
}

variable "github_owner" {
  description = "GitHub 저장소 소유자"
  type        = string
}

variable "github_repo" {
  description = "GitHub 저장소 이름"
  type        = string
}

variable "github_branch" {
  description = "GitHub 브랜치 이름"
  type        = string
}