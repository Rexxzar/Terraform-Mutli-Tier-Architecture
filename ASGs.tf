resource "aws_autoscaling_group" "first-tier-asg" {
  name                      = "first-tier-ags"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 4
  force_delete              = true


  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  target_group_arns   = [aws_lb_target_group.tg1.arn]
  launch_template {
    id      = aws_launch_template.tier1.id
    version = "$Latest"
  }

}
resource "aws_autoscaling_group" "second-tier-asg" {
  name                      = "second-tier-ags"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 4
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.tg2.arn]


  vpc_zone_identifier = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
  launch_template {
    id      = aws_launch_template.tier2.id
    version = "$Latest"
  }

}
