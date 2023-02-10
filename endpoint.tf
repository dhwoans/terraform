resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "s3_routetable" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id = aws_route_table.privateRoute.id
}