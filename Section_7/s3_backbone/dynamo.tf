resource "aws_dynamodb_table" "lock" {
  name           = "terraform-lock-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  # The table must have a primary key named LockID.
  # If not present, locking will be disabled.
  attribute {
    name = "LockID"
    type = "S"
  }
}
