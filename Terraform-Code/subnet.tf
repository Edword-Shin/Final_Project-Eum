### Create VPC Subnet
## create-pub-2a subnet
resource "aws_subnet" "create-pub-2a" {
  vpc_id = aws_vpc.create-vpc.id
  cidr_block = var.pub-2a-cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = var.pub-2a-name
  }
}

output "create-pub-2a-id"{
  value = aws_subnet.create-pub-2a.id
}


## create-pub-2c subnet
resource "aws_subnet" "create-pub-2c" {
  vpc_id = aws_vpc.create-vpc.id
  cidr_block = var.pub-2c-cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = var.pub-2c-name
  }
}

output "create-pub-2c-id"{
  value = aws_subnet.create-pub-2c.id
}



## create-pvt-2a subnet
resource "aws_subnet" "create-pvt-2a" {
  vpc_id = aws_vpc.create-vpc.id
  cidr_block = var.pvt-2a-cidr
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = var.pvt-2a-name
  }
}

output "create-pvt-2a_id"{
  value = aws_subnet.create-pvt-2a.id
}


## create-pvt-2c subnet
resource "aws_subnet" "create-pvt-2c" {
  vpc_id = aws_vpc.create-vpc.id
  cidr_block = var.pvt-2c-cidr
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = var.pvt-2c-name
  }
}

output "create-pvt-2c_id"{
  value = aws_subnet.create-pvt-2c.id
}