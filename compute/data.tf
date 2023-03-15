data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-remote-state-wordpress"
    key    = "vpc.tfstate"
    region = "us-east-1"
  }
}
