// Define the stack name
variable "stack_name" {
  description = "The name of the stack. This will be used to generate the names of other resources."
}

// Define the subnet ID
variable "subnet_id" {
  description = "The ID of the subnet where the EKS cluster and node group will be created."
}

// Define the desired size of the node group
variable "desired_size" {
  description = "The desired number of worker nodes."
}

// Define the maximum size of the node group
variable "max_size" {
  description = "The maximum number of worker nodes that the node group can scale out to."
}

// Define the minimum size of the node group
variable "min_size" {
  description = "The minimum number of worker nodes that the node group can scale in to."
}

// Define local values that will be used to generate the names of the resources
locals {
  iam_role_name    = "${var.stack_name}-role"
  cluster_name     = "${var.stack_name}-cluster"
  node_group_name  = "${var.stack_name}-node-group"
}