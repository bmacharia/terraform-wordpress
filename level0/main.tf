resource "aws_s3_bucket" "terraform_remote_state_wordpress" {
  bucket = "terraform-remote-state-wordpress"

}

resource "aws_dynamodb_table" "terraform_remote" {
  name           = "terraform-remote"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
