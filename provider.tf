terraform {
  required_version = ">= 0.12.1"

  required_providers {
    tls = "~> 2.2"
  }
}

provider "kubernetes" {
  version          = "~> 1.11"
  load_config_file = false
}

provider "aws" {
  version = "~> 2.50"
}

provider "aws" {
  version = "~> 2.50"
  region  = "us-east-1"
  alias   = "us-east"
}

data "aws_region" "current" {}
