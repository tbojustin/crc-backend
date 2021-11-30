resource "aws_dynamodb_table" "main_table" {
  name        = "${var.main_table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = var.main_table_key_name
  #this is important...only define the primary keys or any keys you'll be using to sort
  #let any other attributes get handed by the source code
  attribute {
    name = var.main_table_key_name
    type = "S"
  }
}