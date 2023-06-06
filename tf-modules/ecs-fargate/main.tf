resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "2.0.0"

  name = var.cluster_name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  asg_min_capacity = var.min_size
  asg_max_capacity = var.max_size
  asg_desired_capacity = var.desired_capacity

  instance_type = var.instance_type

  key_name = var.key_name
}
