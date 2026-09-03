terraform {
  required_version = ">= 1.11.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.28"
    }
  }

    backend "s3" {
      bucket = "gp-project-s3-cindia"
      key = "observability/terraform.tfstate"
      # dynamodb_table = "terraform-lock-table"
      use_lockfile = true
      region = "ap-south-1"
      encrypt = true
    }
}