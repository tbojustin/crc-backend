output "aws_s3_bucket_website" {
  value = "${aws_s3_bucket.website.id}"
}

output "aws_s3_bucket_w3" {
  value = "${aws_s3_bucket.w3.id}"
}

output "aws_cloudfront_distribution_website" {
  value = "${aws_cloudfront_distribution.website.id}"
}

output "aws_acm_certificate_website_cert" {
  value = "${aws_acm_certificate.website_cert.id}"
}
