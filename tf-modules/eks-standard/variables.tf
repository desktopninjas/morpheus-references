variable "stack_name" {}
variable "subnet_id" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

locals {
  iam_role_name    = "${var.stack_name}-role"
  cluster_name     = "${var.stack_name}-cluster"
  node_group_name  = "${var.stack_name}-node-group"
}