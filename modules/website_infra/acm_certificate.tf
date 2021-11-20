resource "aws_acm_certificate" "website_cert" {
  domain_name = "www.${var.domain}"
  #yes, I used the www name in my certificate...no regrats

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  subject_alternative_names = [var.domain]
  validation_method         = "DNS"
}
