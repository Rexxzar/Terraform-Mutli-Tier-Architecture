resource "aws_route_table" "privRT" {
  vpc_id = aws_vpc.myvpc.id



  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "public route talbe"
  }
}
resource "aws_route_table_association" "priv1" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.privRT.id
}
resource "aws_route_table_association" "priv2" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.privRT.id
}
