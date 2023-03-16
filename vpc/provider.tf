terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }


  backend "s3" {
    key            = "terraform.tfstate"
    bucket         = "terraform-remote-state-wordpress"
    region         = "us-east-1"
    dynamodb_table = "terraform-remote"
  }

}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "terraform-user"
}
