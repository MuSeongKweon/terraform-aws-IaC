# Elastic IP

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-nat-eip"
  }
}

# NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id //elastic ip connection
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.project}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# NAT route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.project}-private-rt"
  }
}


# NAT Route
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Connect to Private Subnet
resource "aws_route_table_association" "private_assn" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
