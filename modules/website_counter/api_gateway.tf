# Followed this guide: https://registry.terraform.io/providers/hashicorp/aws/2.33.0/docs/guides/serverless-with-aws-lambda-and-api-gateway

resource "aws_api_gateway_rest_api" "counter_api" {
  name        = "crc_counter_api"
  description = "api for the website counter"
}