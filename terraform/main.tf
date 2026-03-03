provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "static_site" {
  bucket = "mystatic-website-2026"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls   = false
  block_public_policy = false
  restrict_public_buckets = false
  ignore_public_acls  = false
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = "s3:GetObject"
      Resource = "${aws_s3_bucket.static_site.arn}/*"
    }]
  })
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id   = "s3Origin"
  }

  enabled = true

  default_cache_behavior {
    target_origin_id       = "s3Origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}