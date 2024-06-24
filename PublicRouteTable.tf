resource "aws_route_table" "pubRT" {
  vpc_id = aws_vpc.myvpc.id



  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public route talbe"
  }
}
resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.pubRT.id
}
resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.pubRT.id
}