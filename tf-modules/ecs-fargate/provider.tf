variable "region" {
  description = "The region in which to create the resources."
  default     = "us-west-2"
}

provider "aws" {
  region = var.region
}
