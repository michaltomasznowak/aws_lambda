terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
    }
    random = {
      source  = "registry.terraform.io/hashicorp/random"
    }
    archive = {
      source  = "registry.terraform.io/hashicorp/archive"
    }
  }

  required_version = ">= 0.12"
}


