#write to database
#read database
#get visit count
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A PYTHON FUNCTION TO AWS LAMBDA
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ----------------------------------------------------------------------------------------------------------------------
# EXAMPLE AWS PROVIDER SETUP
# ----------------------------------------------------------------------------------------------------------------------

#already setup

# ----------------------------------------------------------------------------------------------------------------------
# AWS LAMBDA EXPECTS A DEPLOYMENT PACKAGE
# A deployment package is a ZIP archive that contains your function code and dependencies.
# ----------------------------------------------------------------------------------------------------------------------

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/python/main.py"
  output_path = "${path.module}/python/main.py.zip"
}

# ----------------------------------------------------------------------------------------------------------------------
# DEPLOY THE LAMBDA FUNCTION
# ----------------------------------------------------------------------------------------------------------------------

module "lambda-function" {
  source  = "mineiros-io/lambda-function/aws"
  version = "~> 0.5.0"

  function_name = "python-function"
  description   = "All the Pythonic goodness for the CRC project"
  filename      = data.archive_file.lambda.output_path
  runtime       = "python3.8"
  handler       = "main.lambda_handler"
  timeout       = 30
  memory_size   = 128

  role_arn = module.iam_role.role.arn

}

# ----------------------------------------------------------------------------------------------------------------------
# CREATE AN IAM LAMBDA EXECUTION ROLE WHICH WILL BE ATTACHED TO THE FUNCTION
# ----------------------------------------------------------------------------------------------------------------------

module "iam_role" {
  source  = "mineiros-io/iam-role/aws"
  version = "~> 0.6.1"

  name = "python-function"

  assume_role_principals = [
    {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  ]
  policy_statements = [
    {
      version= "2012-10-17"
      sid="LambdaDynamoDbPolicy"
      effect= "Allow",
      actions= [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ]
      resources= [
        aws_dynamodb_table.counter_table.arn,
        "${aws_dynamodb_table.counter_table.arn}/*"
        ],
        }
  ]
}