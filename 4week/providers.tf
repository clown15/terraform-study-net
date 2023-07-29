terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    profile        = "default"
    bucket         = "terraform-gibum-tfstate"
    key            = "study/4week/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
    # acl            = "bucket-owner-full-control"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "default"
}
