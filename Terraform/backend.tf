resource "aws_dynamodb_table" "count_table" {
  name = "visitors"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

