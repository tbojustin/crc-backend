output "aws_dynamodb_counter" {
  value = "${aws_dynamodb_table.counter_table.id}"
}