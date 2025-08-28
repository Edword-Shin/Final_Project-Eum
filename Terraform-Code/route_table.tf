### Create VPC Route Table
resource "aws_route_table" "create-pub-rtb" {
  vpc_id = aws_vpc.create-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.create-igw.id
  }
  tags = {
    Name = var.pub-rtb-name
  }
}

resource "aws_route_table" "create-pvt-rtb01" {
  vpc_id = aws_vpc.create-vpc.id
  tags = {
    Name = var.pvt-rtb-name01
  }
}

resource "aws_route_table" "create-pvt-rtb02" {
  vpc_id = aws_vpc.create-vpc.id
  tags = {
    Name = var.pvt-rtb-name02
  }
}


## Association Subnet to Route Table
resource "aws_route_table_association" "create-pub-2a-association" {
  subnet_id = aws_subnet.create-pub-2a.id
  route_table_id = aws_route_table.create-pub-rtb.id
}

resource "aws_route_table_association" "create-pub-2c-association" {
  subnet_id = aws_subnet.create-pub-2c.id
  route_table_id = aws_route_table.create-pub-rtb.id
}

resource "aws_route_table_association" "create-pvt-2a-association" {
  subnet_id = aws_subnet.create-pvt-2a.id
  route_table_id = aws_route_table.create-pvt-rtb01.id
}

resource "aws_route_table_association" "create-pvt-2c-association" {
  subnet_id = aws_subnet.create-pvt-2c.id
  route_table_id = aws_route_table.create-pvt-rtb02.id
}