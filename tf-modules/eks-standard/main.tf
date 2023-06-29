// Define the IAM role for EKS
resource "aws_iam_role" "eks_role" {
  name = local.iam_role_name

  managed_policy_arns = [ 
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws-us-gov:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws-us-gov:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// Define the EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role.eks_role
    # aws_iam_role_policy_attachment.eks_cluster_policy,
    # aws_iam_role_policy_attachment.eks_service_policy,
  ]
}

// Define the EKS node group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = local.node_group_name
  node_role_arn   = aws_iam_role.eks_role.arn
  subnet_ids      = var.subnet_ids

  // Define the scaling configuration for the node group
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  // Define the dependencies for the node group
  depends_on = [
    aws_eks_cluster.eks_cluster,
  ]
}