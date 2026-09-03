terraform {
  required_version = ">= 1.11.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28"
    }
  }

  backend "s3" {
      bucket = "gp-project-s3-cindia"
      key = "amg/terraform.tfstate"
      # dynamodb_table = "terraform-lock-table"
      use_lockfile = true
      region = "ap-south-1"
      encrypt = true
    }
}

provider "aws" {
  region = local.region
}