resource "aws_route_table" "publicRoute" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "${var.vpc_name}-public"
  }
}
resource "aws_route_table" "privateRoute" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
      Name = "${var.vpc_name}-private"
  }
}


# 라우팅 테이블 연결
resource "aws_route_table_association" "publicRTAssociation" {
  subnet_id = aws_subnet.publicSubnet.id
  route_table_id = aws_route_table.publicRoute.id
}
resource "aws_route_table_association" "privateRTAssociation" {
  subnet_id = aws_subnet.privateSubnet.id
  route_table_id = aws_route_table.privateRoute.id
}