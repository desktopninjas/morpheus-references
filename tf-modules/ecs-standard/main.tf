resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name

  tags = var.tags
}

data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_launch_template" "lt" {
  name          = "${var.cluster_name}-lt"
  image_id      = var.image_id != "" ? var.image_id : data.aws_ami.ecs.id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = var.iam_instance_profile # Assuming this IAM role exists in your AWS account
  }

  user_data = base64encode(
    data.template_file.user_data.rendered
  )

  tags = var.tags
}

resource "aws_autoscaling_group" "asg" {
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  vpc_zone_identifier = var.subnet_ids  # replace with your subnet IDs

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-asg"
    propagate_at_launch = true
  }

}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    cluster_name = var.cluster_name
    cis_hardening_script = var.cis_hardening_script
  }
}

