resource "aws_dynamodb_table" "counter_table" {
  name        = "${var.counter_table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = "URL_path"
  #this is important...only define the primary keys or any keys you'll be using to sort
  #let any other attributes get handed by the source code
  attribute {
    name = var.counter_table_key_name
    type = "S"
  }
}