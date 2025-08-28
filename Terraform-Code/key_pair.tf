# Create Key-Pair "Bastion-Instance-key"
resource "tls_private_key" "bastion-instance-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion-instance-key-pair" {
  key_name   = var.bastion-key-name
  public_key = tls_private_key.bastion-instance-key.public_key_openssh
}

resource "local_file" "bastion-instance-key-pem" {
  content  = tls_private_key.bastion-instance-key.private_key_pem
  filename = var.bastion-key-name

  file_permission = "0400"
}





# Create Key-Pair "NFS-Instance-key"
resource "tls_private_key" "nfs-instance-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nfs-instance-key-pair" {
  key_name   = var.nfs-key-name
  public_key = tls_private_key.nfs-instance-key.public_key_openssh
}

resource "local_file" "nfs-instance-key-pem" {
  content  = tls_private_key.nfs-instance-key.private_key_pem
  filename = var.nfs-key-name

  file_permission = "0400"
}





# Create Key-Pair "eks-cluster-nodegroup-key"
resource "tls_private_key" "eks-cluster-node_group-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks-cluster-node_group-key-pair" {
  key_name   = var.eks-node-key-name
  public_key = tls_private_key.eks-cluster-node_group-key.public_key_openssh
}

resource "local_file" "eks-cluster-node_group-key-pem" {
  content  = tls_private_key.eks-cluster-node_group-key.private_key_pem
  filename = var.eks-node-key-name

  file_permission = "0400"
}