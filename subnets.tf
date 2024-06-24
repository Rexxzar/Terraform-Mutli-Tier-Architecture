resource "aws_subnet" "subnet1" { #first tier first public subnet
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = var.az1
  map_public_ip_on_launch = true



}
resource "aws_subnet" "subnet2" { #first tier second public subnet
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.az2
  map_public_ip_on_launch = true



}
resource "aws_subnet" "subnet3" { #second tier first private subnet
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.az3
  map_public_ip_on_launch = false



}
resource "aws_subnet" "subnet4" { #second tier second private subnet
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = var.az4
  map_public_ip_on_launch = false



}
resource "aws_subnet" "subnet5" { #third tier first private subnet
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = var.az5
  map_public_ip_on_launch = false



}
resource "aws_subnet" "subnet6" { #third tier seecond private subnet
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = var.az6
  map_public_ip_on_launch = true



}