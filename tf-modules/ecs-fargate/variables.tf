variable "cluster_name" {
  description = "The name of the ECS cluster."
  default     = "default-cluster"
}

variable "instance_type" {
  description = "The instance type of the EC2 instances in the cluster."
  default     = "t2.micro"
}

variable "min_size" {
  description = "The minimum number of instances in the cluster."
  default     = 1
}

variable "max_size" {
  description = "The maximum number of instances in the cluster."
  default     = 2
}

variable "desired_capacity" {
  description = "The desired number of instances in the cluster."
  default     = 1
}

variable "key_name" {
  description = "The name of the key pair to use for the instances."
  default     = "your-key-pair"
}

variable "image_id" {
  description = "The ID of the AMI to use for the instances."
  default     = "ami-0c94855ba95c574c8"  # replace with your AMI ID
}
