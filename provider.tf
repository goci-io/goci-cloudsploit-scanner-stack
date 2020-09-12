terraform {
  required_version = ">= 0.12.1"
}

provider "kubernetes" {
  version          = "~> 1.11"
  load_config_file = false
}

provider "aws" {
  version = "~> 2.50"
}

data "aws_region" "current" {}
