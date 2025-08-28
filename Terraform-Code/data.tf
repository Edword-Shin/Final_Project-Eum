# Data Block "AWS REGION Available Zone" for Subnet
data "aws_availability_zones" "az" {
  state = "available"
}





# Data Block "AMI" for EC2 Instances
data "aws_ami" "amzn2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


data "aws_ami" "ubuntu2204" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical ID
}





### AMI Release Version For EKS Cluster Node Group
data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks-cluster.version}/amazon-linux-2023/x86_64/standard/recommended/release_version"
}