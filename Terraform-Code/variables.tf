### VPC variable
variable "vpc-cidr" {
    type = string
    default = "10.10.0.0/16"
    description = "vpc cidr 정의"
}

variable "vpc-name" {
    type = string
    default = "eum-cloud"
    description = "vpc 이름 정의"
}





### Subnet Variable
## pub-2a variable
variable "pub-2a-cidr" {
    type = string
    default = "10.10.0.0/20"
    description = "pub-2a cidr 정의"
}

variable "pub-2a-name" {
    type = string
    default = "eum-cloud-pub-2a"
    description = "pub-2a-name 이름 정의"
}


## pub-2c variable
variable "pub-2c-cidr" {
    type = string
    default = "10.10.32.0/20"
    description = "pub-2c cidr 정의"
}

variable "pub-2c-name" {
    type = string
    default = "eum-cloud-pub-2c"
    description = "pub-2c-name 이름 정의"
}



## pvt-2a variable
variable "pvt-2a-cidr" {
  type = string
  default = "10.10.64.0/20"
  description = "pvt-2a cidr 정의"
}

variable "pvt-2a-name" {
  type = string
  default = "eum-cloud-pvt-2a"
  description = "pvt-2a 이름 정의"
}


## pvt-2c variable
variable "pvt-2c-cidr" {
  type = string
  default = "10.10.96.0/20"
  description = "pvt-2c cidr 정의"
}

variable "pvt-2c-name" {
  type = string
  default = "eum-cloud-pvt-2c"
  description = "pvt-2c 이름 정의"
}





### Route Table Variable
variable "pub-rtb-name" {
  type = string
  default = "eum-cloud-pub-rtb"
  description = "pub-rtb 이름 정의"
}

variable "pvt-rtb-name01" {
  type = string
  default = "eum-cloud-pvt-rtb-01"
  description = "pvt-rtb 이름 정의"
}

variable "pvt-rtb-name02" {
  type = string
  default = "eum-cloud-pvt-rtb-02"
  description = "pvt-rtb 이름 정의"
}





### IGW Variable
variable "igw-name" {
  type = string
  default = "eum-cloud-igw"
  description = "igw 이름 정의"
}






### Security Group Variable
variable "sg-bastion-name" {
  type = string
  default = "eum-cloud-sg-bastion"
  description = "Bastion Host Security Group 이름 정의"
}


variable "sg-nfs-name" {
  type = string
  default = "eum-cloud-sg-nfs"
  description = "Bastion Host Security Group 이름 정의"
}


variable "sg-eks-cluster-name" {
  type = string
  default = "eum-cloud-eks-cluster-sg"
  description = "seoul-eks-cluster Security Group 이름 정의"
}





### EIP Variable
variable "eip-name01" {
  type = string
  default = "eum-cloud-eip01"
  description = "eip 이름 정의"
}

variable "eip-name02" {
  type = string
  default = "eum-cloud-eip02"
  description = "eip 이름 정의"
}





### NATGW Variable
variable "natgw-name01" {
  type = string
  default = "eum-cloud-natgw01"
  description = "natgw01 이름 정의"
}

variable "natgw-name02" {
  type = string
  default = "eum-cloud-natgw02"
  description = "natgw02 이름 정의"
}





### AMI Variable
variable "ami-id" {
  type = string
  default = "ami-0ea4d4b8dc1e46212"
  description = "Bastion Host ami id 지정"
}





### Instance Variable
variable "instance-type" {
  type = string
  default = "t3.medium"
  description = "EC2 Instance Host의 Instance Type 지정"
}

variable "bastion-instance-name" {
  type = string
  default = "eum-cloud-bastion"
  description = "Bastion Host 이름 지정"
}

variable "nfs-instance-name" {
  type = string
  default = "eum-cloud-nfs"
  description = "NFS-Server EC2 Host 이름 정의"
}





### Key Pair Variable
variable "bastion-key-name" {
  type = string
  default = "eum-cloud-bastion-key"
  description = "Bastion Host Key Pair 이름 지정"
}

variable "nfs-key-name" {
  type = string
  default = "eum-cloud-nfs-key"
  description = "NFS-Server Host Key Pair 이름 지정"
}

variable "eks-node-key-name" {
  type = string
  default = "eum-cloud-eks-node-key"
  description = "EKS Node group의 Worker-Node SSH Key 이름 지정"
}





### EKS Cluster : Cluster Variable
variable "cluster-name" {
  type = string
  default = "eum-eks-cluster"
  description = "EKS Cluster 이름 정의"
}

variable "cluster-role-name" {
  type = string
  default = "eum-eks-cluster-role"
  description = "data로 가져올 cluster role 이름 정의"
}

variable "cluster-add-on-role-name" {
  type = string
  default = "eum-eks-cluster-add-on-role"
  description = "EKS Cluster의 Add-ON 설치를 위한 IAM Role 이름 지정"
}





### EKS Cluster : Node Group Variable
variable "node-group-name" {
  type = string
  default = "eum-eks-workers"
  description = "EKS Cluster Node group의 Worker-Node 이름 지정"
}

variable "node-group-role-name" {
  type = string
  default = "eum-eks-cluster-node_group-role"
  description = "EKS Cluster Node group의 IAM Role 이름 정의"
}

variable "node-group-capacity-type" {
  type = string
  default = "ON_DEMAND"
  description = "EKS Cluster Node group의 capacity type 지정"
}

variable "node-group-instance-types" {
  type = string
  default = "t3.medium"
  description = "EKS Cluster Node group의 instance type 지정"
}

variable "node-group-desired-size" {
  type = string
  default = "3"
  description = "EKS Cluster Node group의 desired size(Autoscaling 기본 시작 Worker-Node 갯수) 지정"
}

variable "node-group-min-size" {
  type = string
  default = "3"
  description = "node group min size(Autoscaling 최소 유지 Worker-Node 갯수) 지정"
}

variable "node-group-max-size" {
  type = string
  default = "10"
  description = "node group max size(Autoscaling 최대 확장 Worker-Node 갯수) 지정"
}