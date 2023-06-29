// Define the stack name
variable "stack_name" {
  description = "The name of the stack. This will be used to generate the names of other resources."
  default     = "FSA-EKS-TPOC"
}

// Define the subnet ID
variable "subnet_ids" {
  description = "The IDs of the subnets where the EKS cluster and node group will be created.  This variable expects a list of strings like this: [\"subnet-08f9a200265c8855e\", \"subnet-09ab52b2975fd23f7\"]"
  type        = list(string)
}

// Define the desired size of the node group
variable "desired_size" {
  description = "The desired number of worker nodes."
  default     = 2
}

// Define the maximum size of the node group
variable "max_size" {
  description = "The maximum number of worker nodes that the node group can scale out to."
  default     = 2
}

// Define the minimum size of the node group
variable "min_size" {
  description = "The minimum number of worker nodes that the node group can scale in to."
  default     = 1
}

// Define local values that will be used to generate the names of the resources
locals {
  iam_role_name   = "${var.stack_name}-role"
  cluster_name    = "${var.stack_name}-cluster"
  node_group_name = "${var.stack_name}-node-group"
}