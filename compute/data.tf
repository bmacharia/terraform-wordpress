data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = "terraform-remote-state-wordpress"
    key    = "compute.terraform.tfstate"
    region = "us-east-1"
  }
}
