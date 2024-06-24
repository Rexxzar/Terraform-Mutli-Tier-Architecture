resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.myvpc.id
  name   = "first tier"

  ingress {

    description     = "http from internet"
    from_port       = 80
    prefix_list_ids = ["value"]
    protocol        = "tcp"


    to_port = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "ALB SG for the first tier "
  }
}
resource "aws_security_group" "asg_sg-tier-1" {
  vpc_id = aws_vpc.myvpc.id
  name   = "first tier asg"

  ingress {

    description = "http from alb"
    from_port   = 80

    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]

    to_port = 80
  }
  ingress {
    description = "ssh from your ip only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.yourpublicip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "ASG SG for the first tier"
  }
}

resource "aws_security_group" "lb_sg-second" {
  vpc_id = aws_vpc.myvpc.id
  name   = "second tier"

  ingress {

    description = "http from web asg"
    from_port   = 80

    protocol        = "tcp"
    security_groups = [aws_security_group.asg_sg-tier-1.id]

    to_port = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "ALB SG for the second tier tier"
  }
}


resource "aws_security_group" "asg_sg-second" {
  vpc_id = aws_vpc.myvpc.id
  name   = "asg sg second tier"

  ingress {

    description = "http from second tier alb"
    from_port   = 80

    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg-second.id]

    to_port = 80
  }
  ingress {

    description = "ssh"
    from_port   = 22

    protocol        = "tcp"
    security_groups = [aws_security_group.asg_sg-tier-1.id]

    to_port = 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "ASG SG for the second tier "
  }
}

resource "aws_security_group" "asg_sg-third" {
  vpc_id = aws_vpc.myvpc.id
  name   = "asg sg third tier"

  ingress {

    description = "db access from application(second) tier"
    from_port   = var.DBport

    protocol        = "tcp"
    security_groups = [aws_security_group.asg_sg-second.id]

    to_port = var.DBport
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "ASG SG for the third tier "
  }
}