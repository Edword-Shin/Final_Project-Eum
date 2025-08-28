### Create VPC EIP & NAT-GW
## EIP
resource "aws_eip" "create-eip-nat-gw01" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
  
  tags = {
    Name = var.eip-name01
  }
}

resource "aws_eip" "create-eip-nat-gw02" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
  
  tags = {
    Name = var.eip-name02
  }
}





##NAT-GW
resource "aws_nat_gateway" "create-nat-gw01" {
  allocation_id = aws_eip.create-eip-nat-gw01.id

  subnet_id = aws_subnet.create-pub-2a.id

  tags = {
    Name = var.natgw-name01
  }
}

## NAT-GW01 & pvt-rtb01 routetable routing setting
resource "aws_route" "pvt-rtb01-create-nat-gw01" {
  route_table_id              = aws_route_table.create-pvt-rtb01.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.create-nat-gw01.id
}

# resource "aws_route" "pvt-rtb02-create-nat-gw01" {
#   route_table_id              = aws_route_table.create-pvt-rtb02.id
#   destination_cidr_block      = "0.0.0.0/0"
#   nat_gateway_id              = aws_nat_gateway.create-nat-gw01.id
# }


resource "aws_nat_gateway" "create-nat-gw02" {
  allocation_id = aws_eip.create-eip-nat-gw02.id

  subnet_id = aws_subnet.create-pub-2c.id

  tags = {
    Name = var.natgw-name02
  }
}

## NAT-GW02 & pvt-rtb02 routetable routing setting
resource "aws_route" "pvt-rtb-create-nat-gw02" {
  route_table_id              = aws_route_table.create-pvt-rtb02.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.create-nat-gw02.id
}