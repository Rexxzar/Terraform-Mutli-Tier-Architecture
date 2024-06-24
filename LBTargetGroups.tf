resource "aws_lb_target_group" "tg1" {
  name     = "tier1TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
  health_check {
    path    = "/"
    matcher = 200

  }
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.first-tier-alb.id
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}
resource "aws_lb_target_group" "tg2" {
  name     = "tier2TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
  health_check {
    path    = "/"
    matcher = 200

  }
}
resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.second-tier-alb.id
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg2.arn
  }
}