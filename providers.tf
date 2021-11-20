provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      version = "~> 3.63.0"
    }
    backend "remote" {
    organization = "AWS_DEMO_TBO"

    workspaces {
      name = "crc-backend"
    }
  }
  }
}
