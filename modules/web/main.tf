# CloudFront OAI (Origin Access Identity)
resource "aws_cloudfront_origin_access_identity" "web" {
  comment = "${var.project_name}-${var.environment}-oai"
}

# CloudFront 배포
resource "aws_cloudfront_distribution" "web" {
  enabled             = true
  is_ipv6_enabled    = true
  default_root_object = "index.html"
  price_class        = "PriceClass_100" # 가장 저렴한 옵션 선택

  origin {
    domain_name = "${var.bucket_id}.s3.amazonaws.com"
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.web.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-distribution"
    Environment = var.environment
  }
}

# S3 버킷 정책 업데이트 (CloudFront OAI 접근 허용)
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.web.iam_arn]
    }
  }
}