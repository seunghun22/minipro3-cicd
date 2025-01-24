variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment" {
  description = "환경 (dev, prod 등)"
  type        = string
}

variable "force_destroy" {
  description = "버킷 삭제 시 내용물도 함께 삭제"
  type        = bool
  default     = true
}

variable "versioning_enabled" {
  description = "버킷 버저닝 활성화 여부"
  type        = bool
  default     = true
}