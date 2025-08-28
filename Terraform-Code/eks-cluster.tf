### Create EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = "1.32"

  enabled_cluster_log_types = [
    "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  vpc_config {
    security_group_ids      = [aws_security_group.create-eks-cluster-sg.id]
    subnet_ids              = [
      aws_subnet.create-pub-2a.id,
      aws_subnet.create-pub-2c.id
    ]
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-role-aws-eks-cluster-policy,
    aws_iam_role_policy_attachment.eks-cluster-role-aws-eks-VPCResourceController
  ]
}

output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

### IAM OIDC Provider
data "tls_certificate" "eks-cluster-tls-certificate" {
  url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-cluster-oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.eks-cluster-tls-certificate.certificates[0].sha1_fingerprint
  ]
  url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

### CNI Add-on Role (IRSA)
data "aws_iam_policy_document" "cni-assume-role" {
  statement {
    actions   = ["sts:AssumeRoleWithWebIdentity"]
    effect    = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks-cluster-oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }
    principals {
      identifiers = [aws_iam_openid_connect_provider.eks-cluster-oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks-addon-role" {
  assume_role_policy = data.aws_iam_policy_document.cni-assume-role.json
  name               = var.cluster-add-on-role-name
}

resource "aws_iam_role_policy_attachment" "cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-addon-role.name
}

### Cluster Add-ons
resource "aws_eks_addon" "vpc-cni" {
  cluster_name             = aws_eks_cluster.eks-cluster.name
  addon_name               = "vpc-cni"
  addon_version            = "v1.19.5-eksbuild.1"
  service_account_role_arn = aws_iam_role.eks-addon-role.arn
}

resource "aws_eks_addon" "coredns" {
  cluster_name             = aws_eks_cluster.eks-cluster.name
  addon_name               = "coredns"
  addon_version            = "v1.11.4-eksbuild.2"
  service_account_role_arn = aws_iam_role.eks-addon-role.arn
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name             = aws_eks_cluster.eks-cluster.name
  addon_name               = "kube-proxy"
  addon_version            = "v1.32.0-eksbuild.2"
  service_account_role_arn = aws_iam_role.eks-addon-role.arn
  depends_on               = [aws_eks_node_group.eks-cluster-nodes-group]
}

### 추가: EBS/EFS CSI Add-ons
resource "aws_eks_addon" "ebs-csi" {
  cluster_name      = aws_eks_cluster.eks-cluster.name
  addon_name        = "aws-ebs-csi-driver"
}

resource "aws_eks_addon" "efs-csi" {
  cluster_name      = aws_eks_cluster.eks-cluster.name
  addon_name        = "aws-efs-csi-driver"
}