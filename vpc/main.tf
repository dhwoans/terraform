resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "privateSubnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "publicSubnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = var.name
  }
}

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
#nat gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.publicSubnet.id
}
#internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_eip" "eip" {
  vpc = true
  
  lifecycle{
    create_before_destroy=true
  }
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "s3_routetable" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id = aws_route_table.privateRoute.id
}

# 시큐리티 그룹
resource "aws_security_group" "vpc_allow_all" {
  name = "vpc_allow_all"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.test_vpc_tag_name} sg"
  }
}

