### Create VPC
resource "aws_vpc" "create-vpc" {
  cidr_block  = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = var.vpc-name
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

output "create-vpc-id"{
  value = aws_vpc.create-vpc.id
}