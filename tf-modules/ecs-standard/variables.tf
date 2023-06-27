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

variable "iam_instance_profile" {
  description = "Instance role to apply to instances in the ECS cluster"
  default     = ""
}

variable "key_name" {
  description = "The name of the key pair to use for the instances."
  default     = "your-key-pair"
}

variable "image_id" {
  description = "The ID of the AMI to use for the instances.  If empty, Terraform will fetch the latest ami from AWS."
  default     = "" 
}

variable "cis_hardening_script" {
  description = "https path to the CIS hardening script to be executed on the node after startup."
  default     = "https://location-to-your-script/cis-hardening-script.sh"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}