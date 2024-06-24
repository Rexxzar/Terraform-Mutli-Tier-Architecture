resource "aws_lb" "first-tier-alb" {
  name               = "first-tier"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = var.albbucket
    prefix  = "alb-bucket"
    enabled = true
  }

  tags = {
    Environment = "first-tier"
  }
}
resource "aws_lb" "second-tier-alb" {
  name               = "second-tier"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg-second.id]
  subnets            = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = var.albbucket
    prefix  = "alb-bucket"
    enabled = true
  }

  tags = {
    Environment = "second-tier"
  }
}
