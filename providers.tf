# For provider setting

terraform {
  backend "s3" {
    bucket = "terraform-state-museong-eks"
    key    = "eks/terraform.tfstate"
    region = "ap-northeast-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
}
