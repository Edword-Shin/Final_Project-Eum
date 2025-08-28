### Create VPC Internet Gateway
resource "aws_internet_gateway" "create-igw" {
  vpc_id = aws_vpc.create-vpc.id
  tags = {
    Name = var.igw-name
  }
}