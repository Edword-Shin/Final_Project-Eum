### Seoul Center VPC EKS Cluster Node Group
resource "aws_eks_node_group" "eks-cluster-nodes-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.node-group-name

  version = aws_eks_cluster.eks-cluster.version
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  node_role_arn   = aws_iam_role.eks-cluster-nodes-group-role.arn
  subnet_ids = [
    aws_subnet.create-pvt-2a.id,
    aws_subnet.create-pvt-2c.id
  ]

  remote_access {
    ec2_ssh_key = var.eks-node-key-name
  }

  capacity_type = var.node-group-capacity-type
  instance_types = [var.node-group-instance-types]
  disk_size = 30

  scaling_config {
    desired_size = var.node-group-desired-size
    min_size     = var.node-group-min-size
    max_size     = var.node-group-max-size
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-nodes-group-aws-eks-worker-node-policy,
    aws_iam_role_policy_attachment.eks-cluster-nodes-group-aws-eks-cni-policy,
    aws_iam_role_policy_attachment.eks-cluster-nodes-group-aws-ec2-container-registry-read-only
  ]
  
  tags = {
    Name = var.node-group-name
  }
}