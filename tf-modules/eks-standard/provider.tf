terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4.0"
    }
  }
}

provider "aws" {
  # profile = "hmcp-aws"
  region     = var.region
  access_key = var.ngdc_terraform_access_key
  secret_key = var.ngdc_terraform_secret_access_key
}

#Provider 
variable "region" {
  type    = string
  default = "us-gov-west-1"
}

variable "ngdc_terraform_access_key" {
  type    = string
}

variable "ngdc_terraform_secret_access_key" {
  type    = string
}

# IRAD Account Test Env
# provider "aws" {
#   profile = "irad-aws"
#   region = var.region
# }