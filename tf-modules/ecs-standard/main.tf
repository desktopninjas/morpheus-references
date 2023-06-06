resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name

  tags = var.tags
}

resource "aws_launch_configuration" "lc" {
  name          = "${var.cluster_name}-lc"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile = "ecsInstanceRole"  # Assuming this IAM role exists in your AWS account

  user_data = base64encode(
    data.template_file.user_data.rendered
  )

  tags = var.tags
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.lc.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  vpc_zone_identifier = ["subnet-abcde012", "subnet-bcde012a"]  # replace with your subnet IDs

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-asg"
    propagate_at_launch = true
  }

  tags = var.tags
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    cluster_name = var.cluster_name
    cis_hardening_script = var.cis_hardening_script
  }
}

