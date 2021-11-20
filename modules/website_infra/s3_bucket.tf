resource "aws_s3_bucket" "website" {
  bucket        = var.domain
  force_destroy = true

provisioner "local-exec" {
    command = "aws s3 sync ${var.webpath} s3://${aws_s3_bucket.website.id}"
  }
  request_payer = "BucketOwner"

  versioning {
    enabled    = "false"
    mfa_delete = "false"
  }

  website {
    error_document = "404.html"
    index_document = "index.html"
  }

}

resource "aws_s3_bucket" "w3" {
  bucket         = "www.${var.domain}"
  force_destroy  = true
  request_payer  = "BucketOwner"

  versioning {
    enabled    = "false"
    mfa_delete = "false"
  }

  website {
    redirect_all_requests_to = "http://${var.domain}"
  }

}

resource "aws_s3_bucket" "log_bucket" {
  bucket         = "${var.domain}-log"
  force_destroy  = true
  request_payer  = "BucketOwner"

  versioning {
    enabled    = "false"
    mfa_delete = "false"
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "WebsiteBucketPolicy"
    "Statement": [
    {
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Resource": [
        aws_s3_bucket.website.arn,
        "${aws_s3_bucket.website.arn}/*"
      ]
      "Sid": "PublicReadGetObject"
    }
  ],
  })
}