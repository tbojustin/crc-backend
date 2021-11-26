# Pulled from here: https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/latest

module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "count-http"
  description   = "Website HTTP API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  # Custom domain
  domain_name                 = var.site_name
  domain_name_certificate_arn = var.counter_domain_arn

  # Access logs
  #default_stage_access_log_destination_arn = "arn:aws:logs:eu-west-1:835367859851:log-group:debug-apigateway"
  #default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    /*"POST /" = {
      lambda_arn             = "arn:aws:lambda:eu-west-1:052235179155:function:my-function"
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    } */

    "$default" = {
      lambda_arn = module.lambda-function.function.invoke_arn
    }
  }

  tags = {
    Name = "http-apigateway"
  }
}