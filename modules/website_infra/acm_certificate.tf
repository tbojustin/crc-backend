resource "aws_acm_certificate" "website_cert" {
  domain_name = var.domain

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  subject_alternative_names = ["www.${var.domain}"]
  validation_method         = "DNS"
}
